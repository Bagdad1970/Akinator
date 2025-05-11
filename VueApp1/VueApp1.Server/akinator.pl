:- dynamic animal/2, question/3, answer/3, characteristic/3.

% Вопросы
question(1, 'Является ли животное млекопитающим?', [yes, no]).
question(2, 'Живет ли животное в воде?', [yes, no]).
question(3, 'Является ли животное хищником?', [yes, no]).
question(4, 'Умеет ли животное летать?', [yes, no]).
question(5, 'Живет ли животное в Арктике?', [yes, no]).
question(6, 'Живет ли животное в Африке?', [yes, no]).
question(7, 'Имеет ли животное полосы?', [yes, no]).
question(8, 'Является ли животное ядовитым?', [yes, no]).
question(9, 'Имеет ли животное рыжий окрас?', [yes, no]).

% Животные
animal('Slon', [yes, no, no, no, no, yes, no, no, no]).
animal('Zebra', [yes, no, no, no, no, yes, yes, no, no]).

% Основной цикл игры
play :-
    nl,
    retractall(answer(_, _, _)),
    ask_questions([]).

% Получение максимального ID вопроса
get_max_question_id(MaxID) :-
    findall(ID, question(ID, _, _), IDs),
    (IDs = [] -> MaxID = 0; max_list(IDs, MaxID)).

% Задавание вопросов
ask_questions(Answers) :-
    findall(Animal, matches(Animal, Answers), Candidates),
    length(Answers, NumAnswers),
    (   Candidates = [Animal] ->
        make_guess(Animal, Answers)
    ;   get_max_question_id(MaxID),
        NumAnswers >= MaxID ->
        learn_new_animal(Answers, Candidates)
    ;   Candidates = [] ->
        select_next_question(Answers, [], QuestionID, QuestionText),
        ask_question(QuestionID, QuestionText, Answers)
    ;   select_next_question(Answers, Candidates, QuestionID, QuestionText),
        ask_question(QuestionID, QuestionText, Answers)
    ).

% Проверка соответствия животного ответам
matches(Animal, Answers) :-
    animal(Animal, Features),
    check_answers(Answers, Features, Animal).

check_answers([], _, _).
check_answers([answer(QID, Ans)|Rest], Features, Animal) :-
    (   QID =< 9 ->  % Проверяем основные характеристики (первые 9 вопросов)
        nth1(QID, Features, Ans)
    ;   characteristic(QID, Animal, Ans)  % Проверяем дополнительные характеристики
    ),
    check_answers(Rest, Features, Animal).

% Выбор следующего вопроса
select_next_question(Answers, Candidates, QID, Text) :-
    findall(QID, (question(QID, _, _), \+ member(answer(QID, _), Answers)), QIDs),
    (   Candidates \= [] ->
        best_question(QIDs, Candidates, QID)
    ;   QIDs = [QID|_]
    ),
    question(QID, Text, _).

% Эвристика для выбора вопроса
best_question(QIDs, Candidates, BestQID) :-
    findall(Score-QID, (member(QID, QIDs), score_question(QID, Candidates, Score)), Scores),
    sort(Scores, [_-BestQID|_]).

score_question(QID, Candidates, Score) :-
    question(QID, _, Options),
    count_answers(QID, Options, Candidates, Counts),
    variance(Counts, Variance),
    Score is -Variance.

count_answers(QID, Options, Candidates, Counts) :-
    findall(Ans, (member(Animal, Candidates), get_feature(QID, Animal, Ans)), Answers),
    count_each(Options, Answers, Counts).

get_feature(QID, Animal, Ans) :-
    (   QID =< 9 ->  % Для первых 9 вопросов берем из списка характеристик
        animal(Animal, Features),
        nth1(QID, Features, Ans)
    ;   characteristic(QID, Animal, Ans)  % Для остальных - из отдельных фактов
    ).

count_each([], _, []).
count_each([Opt|Opts], Answers, [C|Cs]) :-
    include(=(Opt), Answers, Matches),
    length(Matches, C),
    count_each(Opts, Answers, Cs).

variance(List, Variance) :-
    length(List, N),
    sum_list(List, Sum),
    Avg is Sum / N,
    findall(D2, (member(X, List), D is X - Avg, D2 is D * D), Squares),
    sum_list(Squares, SumSquares),
    Variance is SumSquares / N.

% Задавание вопроса и получение ответа
ask_question(QID, Text, Answers) :-
    write('Вопрос: '), write(Text), nl,
    question(QID, _, Options),
    read(Answer),
    (   member(Answer, Options) ->
        assertz(answer(QID, Answer)),
        ask_questions([answer(QID, Answer)|Answers])
    ;   write('Пожалуйста, введите yes или no.'), nl,
        ask_question(QID, Text, Answers)
    ).

% Вывод предположения
make_guess(Animal, Answers) :-
    write('Предположение: Это '), write(Animal), write('?'), nl,
    read(Confirm),
    (   member(Confirm, [yes, no]) ->
        (   Confirm = yes ->
            write('Отлично! Я угадал!'), nl
        ;   get_max_question_id(MaxID),
            length(Answers, NumAnswers),
            (   NumAnswers >= MaxID ->
                add_new_question_for_incorrect(Answers, Animal)
            ;   select_next_question(Answers, [], QuestionID, QuestionText),
                ask_question(QuestionID, QuestionText, Answers)
            )
        )
    ;   write('Пожалуйста, введите yes или no.'), nl,
        make_guess(Animal, Answers)
    ).

% Обучение новому животному
learn_new_animal(Answers, Candidates) :-
    (   Candidates = [ExistingAnimal] ->
        write('Сообщение: Кажется, ваша комбинация ответов совпадает с '), 
        write(ExistingAnimal), write('. Как называется ваше животное?'), nl
    ;   write('Сообщение: Нет животного, соответствующего вашим ответам. Как называется ваше животное?'), nl
    ),
    read(NewAnimal),
    (   atom(NewAnimal) ->
        (   Candidates = [ExistingAnimal] ->
            add_new_question(Answers, NewAnimal, ExistingAnimal)
        ;   build_features(Answers, Features),
            assertz(animal(NewAnimal, Features)),
            save_animal(NewAnimal, Features),
            write('Спасибо! Я запомнил животное '), write(NewAnimal), write('.'), nl,
            write('Игра завершена.'), nl
        )
    ;   write('Пожалуйста, введите корректное имя животного (в одинарных кавычках, например, ''Tiger'').'), nl,
        learn_new_animal(Answers, Candidates)
    ).

% Построение списка характеристик
build_features(Answers, Features) :-
    findall(Ans, (
        between(1, 9, QID),  % Только первые 9 вопросов сохраняем в списке характеристик
        (member(answer(QID, Ans), Answers) -> true ; Ans = no)
    ), Features).

% Добавление нового вопроса
add_new_question(Answers, NewAnimal, ExistingAnimal) :-
    write('Пожалуйста, введите новый вопрос, который отличает '), 
    write(NewAnimal), write(' от '), write(ExistingAnimal), 
    write(' (в одинарных кавычках, например, ''Имеет ли животное пятна?'').'), nl,
    read(NewQuestionText),
    (   atom(NewQuestionText) ->
        write('Какой ответ для '), write(NewAnimal), write(' на этот вопрос? (yes/no)'), nl,
        read(NewAnimalAnswer),
        (   member(NewAnimalAnswer, [yes, no]) ->
            opposite_answer(NewAnimalAnswer, ExistingAnimalAnswer),
            get_max_question_id(LastQID),
            NewQID is LastQID + 1,
            assertz(question(NewQID, NewQuestionText, [yes, no])),
            build_features(Answers, BaseFeatures),
            assertz(animal(NewAnimal, BaseFeatures)),
            assertz(characteristic(NewQID, NewAnimal, NewAnimalAnswer)),
            assertz(characteristic(NewQID, ExistingAnimal, ExistingAnimalAnswer)),
            save_question(NewQID, NewQuestionText),
            save_animal(NewAnimal, BaseFeatures),
            save_characteristic(NewQID, NewAnimal, NewAnimalAnswer),
            save_characteristic(NewQID, ExistingAnimal, ExistingAnimalAnswer),
            write('Спасибо! Я добавил новый вопрос и запомнил животное '), write(NewAnimal), write('.'), nl,
            write('Игра завершена.'), nl
        ;   write('Пожалуйста, введите yes или no.'), nl,
            add_new_question(Answers, NewAnimal, ExistingAnimal)
        )
    ;   write('Пожалуйста, введите корректный текст вопроса (в одинарных кавычках).'), nl,
        add_new_question(Answers, NewAnimal, ExistingAnimal)
    ).

% Добавление вопроса при неверном предположении
add_new_question_for_incorrect(Answers, IncorrectAnimal) :-
    write('Сообщение: Как называется ваше животное?'), nl,
    read(NewAnimal),
    (   atom(NewAnimal) ->
        write('Пожалуйста, введите новый вопрос, который отличает '), 
        write(NewAnimal), write(' от '), write(IncorrectAnimal), 
        write(' (в одинарных кавычках, например, ''Имеет ли животное пятна?'').'), nl,
        read(NewQuestionText),
        (   atom(NewQuestionText) ->
            write('Какой ответ для '), write(NewAnimal), write(' на этот вопрос? (yes/no)'), nl,
            read(NewAnimalAnswer),
            (   member(NewAnimalAnswer, [yes, no]) ->
                opposite_answer(NewAnimalAnswer, IncorrectAnimalAnswer),
                get_max_question_id(LastQID),
                NewQID is LastQID + 1,
                assertz(question(NewQID, NewQuestionText, [yes, no])),
                build_features(Answers, BaseFeatures),
                assertz(animal(NewAnimal, BaseFeatures)),
                assertz(characteristic(NewQID, NewAnimal, NewAnimalAnswer)),
                assertz(characteristic(NewQID, IncorrectAnimal, IncorrectAnimalAnswer)),
                save_question(NewQID, NewQuestionText),
                save_animal(NewAnimal, BaseFeatures),
                save_characteristic(NewQID, NewAnimal, NewAnimalAnswer),
                save_characteristic(NewQID, IncorrectAnimal, IncorrectAnimalAnswer),
                write('Спасибо! Я добавил новый вопрос и запомнил животное '), write(NewAnimal), write('.'), nl,
                write('Игра завершена.'), nl
            ;   write('Пожалуйста, введите yes или no.'), nl,
                add_new_question_for_incorrect(Answers, IncorrectAnimal)
            )
        ;   write('Пожалуйста, введите корректный текст вопроса (в одинарных кавычках).'), nl,
            add_new_question_for_incorrect(Answers, IncorrectAnimal)
        )
    ;   write('Пожалуйста, введите корректное имя животного (в одинарных кавычках, например, ''Tiger'').'), nl,
        add_new_question_for_incorrect(Answers, IncorrectAnimal)
    ).

% Вспомогательные предикаты
opposite_answer(yes, no).
opposite_answer(no, yes).

save_animal(NewAnimal, Features) :-
    open('akinator.pl', append, Stream),
    write(Stream, 'animal('),
    writeq(Stream, NewAnimal),
    write(Stream, ', '),
    writeq(Stream, Features),
    write(Stream, ').\n'),
    close(Stream).

save_question(QID, QuestionText) :-
    open('akinator.pl', append, Stream),
    write(Stream, 'question('),
    write(Stream, QID),
    write(Stream, ', '),
    writeq(Stream, QuestionText),
    write(Stream, ', [yes, no]).\n'),
    close(Stream).

save_characteristic(QID, Animal, Answer) :-
    open('akinator.pl', append, Stream),
    write(Stream, 'characteristic('),
    write(Stream, QID),
    write(Stream, ', '),
    writeq(Stream, Animal),
    write(Stream, ', '),
    write(Stream, Answer),
    write(Stream, ').\n'),
    close(Stream).



animal(no, [yes,yes,no,no,no,no,no,no,no]).
animal(no, [yes,no,no,no,no,no,no,no,yes]).
