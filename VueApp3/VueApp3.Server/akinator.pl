:- dynamic animal/2, question/3, answer/3, characteristic/3, incorrect_guess/0.

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

animal('African Fish Eagle', [no, no, yes, yes, no, yes, no, no, no]).
animal('Angelfish', [no, yes, no, no, no, yes, yes, no, no]).
animal('Ant', [no, no, yes, no, no, yes, no, yes, yes]).
animal('Arctic Cod', [no, yes, yes, no, yes, no, no, no, no]).
animal('Arctic Skua', [no, no, yes, yes, yes, no, yes, no, no]).
animal('Arctic Tern', [no, no, yes, yes, yes, no, no, no, no]).
animal('Banded Mongoose', [yes, no, yes, no, no, no, yes, no, no]).
animal('Barracuda', [no, yes, yes, no, no, yes, yes, no, no]).
animal('Bat-Eared Fox', [yes, no, yes, yes, no, yes, no, no, yes]).
animal('Bear', [yes, no, yes, no, no, no, no, no, no]).
animal('Beluga Whale', [yes, yes, yes, no, yes, no, no, no, no]).
animal('Black Mamba', [no, no, yes, no, no, yes, no, yes, no]).
animal('Blue-Ringed Octopus', [no, yes, yes, no, no, no, no, yes, yes]).
animal('Bowhead Whale', [yes, yes, no, no, yes, no, no, no, no]).
animal('Box Jellyfish', [no, yes, yes, no, no, yes, no, yes, no]).
animal('Brazilian Wandering Spider', [no, no, yes, no, no, no, yes, yes, no]).
animal('Cancer', [no, yes, yes, no, yes, yes, no, no, yes]).
animal('Cape Buffalo', [yes, no, no, no, yes, yes, yes, no, no]).
animal('Cape Cobra', [no, no, yes, no, no, yes, yes, yes, yes]).
animal('Capelin', [no, yes, yes, no, yes, no, no, no, yes]).
animal('Caracal', [yes, no, yes, no, no, yes, yes, yes, no]).
animal('Cheetah', [yes, no, yes, no, no, yes, no, no, no]).
animal('Clownfish', [no, yes, no, no, no, no, yes, no, yes]).
animal('Coral Snake', [no, no, yes, no, no, no, yes, yes, yes]).
animal('Cow', [yes, no, no, no, no, no, no, no, no]).
animal('Crane', [no, yes, no, yes, no, yes, no, no, no]).
animal('Crocodile', [no, no, yes, no, no, yes, no, no, no]).
animal('Dog', [yes, no, yes, no, no, no, no, no, yes]).
animal('Dolphin', [yes, yes, yes, no, no, yes, no, no, no]).
animal('Duck', [no, no, no, yes, no, no, no, no, no]).
animal('Eagle', [no, no, yes, yes, no, no, no, no, no]).
animal('Emu', [no, no, no, no, no, no, no, no, yes]).
animal('Fennec Fox', [yes, no, yes, no, yes, yes, no, no, yes]).
animal('Firefly', [no, no, no, yes, yes, yes, no, no, no]).
animal('Fisher', [no, no, yes, no, yes, no, yes, yes, no]).
animal('Flamingo', [no, yes, no, yes, no, yes, no, no, yes]).
animal('Frog', [no, yes, yes, no, no, yes, no, yes, no]).
animal('Gaboon Viper', [no, no, yes, no, yes, yes, no, yes, yes]).
animal('Gila Monster', [no, no, yes, no, no, no, no, yes, no]).
animal('Giraffe', [yes, no, no, no, no, yes, yes, no, yes]).
animal('Greenland Shark', [no, yes, yes, no, yes, no, yes, no, no]).
animal('Gyrfalcon', [no, no, yes, yes, yes, no, yes, no, yes]).
animal('Hare', [yes, no, no, no, yes, no, no, no, yes]).
animal('Hawk', [no, no, yes, yes, no, yes, yes, no, no]).
animal('Hawk Moth', [no, no, no, yes, no, no, no, no, yes]).
animal('Honey Badger', [yes, no, no, no, yes, yes, yes, yes, yes]).
animal('Hooded Seal', [yes, no, yes, no, yes, no, no, yes, no]).
animal('Horned Viper', [no, no, no, yes, no, yes, no, yes, yes]).
animal('Hornet', [no, no, yes, yes, no, no, yes, yes, no]).
animal('Horse', [yes, no, no, no, yes, yes, no, no, no]).
animal('Humpback Whale', [yes, yes, no, no, yes, yes, yes, no, no]).
animal('Hyena', [yes, no, yes, no, no, yes, yes, no, no]).
animal('Impala', [yes, no, no, no, yes, yes, yes, no, yes]).
animal('Inland Taipan', [no, no, yes, no, no, no, no, yes, yes]).
animal('Ivory Gull', [no, no, no, yes, yes, no, yes, yes, no]).
animal('Jackal', [yes, no, yes, no, yes, yes, no, no, no]).
animal('Jaeger', [no, no, yes, yes, yes, no, no, yes, no]).
animal('Jellyfish', [no, yes, no, no, yes, yes, no, yes, no]).
animal('Kea', [no, no, yes, yes, no, no, no, no, yes]).
animal('King Cobra', [no, no, no, no, no, yes, no, yes, yes]).
animal('Kittiwake', [no, no, no, yes, yes, no, yes, yes, yes]).
animal('Komodo Dragon', [no, no, yes, no, no, no, no, no, yes]).
animal('Krill', [no, yes, no, no, yes, no, no, yes, no]).
animal('Leopard', [yes, no, yes, no, no, yes, yes, yes, yes]).
animal('Lilac-Breasted Roller', [no, no, no, yes, no, yes, yes, no, yes]).
animal('Lion', [yes, no, yes, no, no, yes, no, no, yes]).
animal('Lionfish', [no, yes, no, no, no, no, no, yes, yes]).
animal('Lynx', [yes, no, yes, no, yes, no, yes, no, no]).
animal('Macaw', [no, no, no, yes, no, no, yes, no, yes]).
animal('Manta Ray', [no, yes, no, no, no, no, yes, no, no]).
animal('Marabou Stork', [no, no, no, yes, no, yes, yes, no, no]).
animal('Merlin', [no, no, yes, yes, yes, no, yes, yes, yes]).
animal('Mink', [yes, no, yes, no, yes, no, yes, yes, yes]).
animal('Mojave Rattlesnake', [no, no, yes, yes, yes, yes, no, yes, no]).
animal('Monarch Butterfly', [no, no, no, no, no, no, yes, yes, yes]).
animal('Monitor Lizard', [no, no, yes, no, no, no, yes, no, no]).
animal('Monkey', [yes, no, no, no, no, yes, no, no, yes]).
animal('Moray Eel', [no, yes, no, no, no, yes, no, no, no]).
animal('Narwhal', [yes, no, no, no, yes, no, no, no, no]).
animal('Okapi', [yes, no, no, no, no, no, yes, no, yes]).
animal('Osprey', [no, no, yes, yes, yes, yes, no, no, no]).
animal('Painted Stork', [no, no, yes, yes, yes, yes, yes, no, no]).
animal('Parrot', [no, no, no, yes, no, no, yes, yes, yes]).
animal('Parrotfish', [no, yes, no, no, no, yes, no, no, yes]).
animal('Peregrine Falcon', [no, no, no, yes, yes, no, no, yes, yes]).
animal('Pigeon', [no, no, no, yes, yes, yes, no, no, no]).
animal('Polar Bear', [yes, no, no, no, yes, no, yes, yes, no]).
animal('Pomarine Jaeger', [no, no, yes, yes, yes, no, no, yes, yes]).
animal('Puff Adder', [no, no, no, no, yes, yes, no, yes, yes]).
animal('Pufferfish', [no, yes, no, no, no, no, yes, yes, yes]).
animal('Quetzal', [no, no, no, yes, no, no, yes, no, no]).
animal('Rat', [yes, no, no, no, yes, yes, no, no, yes]).
animal('Rattlesnake', [no, no, no, yes, yes, yes, no, yes, no]).
animal('Raven', [no, no, yes, yes, no, no, yes, no, yes]).
animal('Red Wolf', [yes, no, yes, no, yes, no, no, no, yes]).
animal('Red kangaroo', [yes, no, no, no, no, no, no, no, yes]).
animal('Red-Bellied Snake', [no, no, no, no, no, yes, yes, yes, yes]).
animal('Red-Billed Oxpecker', [no, no, no, yes, yes, yes, no, no, yes]).
animal('Red-Throated Loon', [no, no, yes, yes, yes, no, no, no, yes]).
animal('Redback Spider', [no, no, no, no, no, no, no, yes, yes]).
animal('Rhinoceros', [yes, no, no, no, no, yes, no, no, no]).
animal('Ringed Seal', [yes, no, no, no, yes, no, yes, yes, yes]).
animal('Rinkhals', [no, no, yes, no, yes, yes, no, yes, no]).
animal('Ross', [no, no, no, yes, yes, no, no, no, yes]).
animal('Saddle-Billed Stork', [no, no, yes, yes, no, yes, yes, no, yes]).
animal('Saw-Scaled Viper', [no, no, yes, yes, no, yes, no, yes, yes]).
animal('Scorpion', [no, no, yes, no, no, yes, no, yes, yes]).
animal('Scorpionfish', [no, yes, no, no, no, yes, yes, yes, no]).
animal('Sea Anemone', [no, yes, no, no, no, no, no, yes, no]).
animal('Sea Snake', [no, yes, no, no, no, yes, no, yes, yes]).
animal('Shark', [no, yes, yes, no, yes, yes, no, no, no]).
animal('Snow Bunting', [no, no, no, yes, yes, no, yes, no, yes]).
animal('Snow Goose', [no, no, no, yes, yes, no, no, no, no]).
animal('Snowy Egret', [no, no, yes, yes, yes, no, yes, yes, no]).
animal('Snowy Owl', [no, no, no, no, yes, no, no, yes, yes]).
animal('Spotted Hyena', [yes, no, yes, no, yes, yes, yes, no, yes]).
animal('Springbok', [yes, no, no, yes, yes, yes, yes, no, yes]).
animal('Stonefish', [no, yes, no, no, no, no, yes, yes, no]).
animal('Suricate', [yes, no, no, yes, yes, yes, yes, yes, yes]).
animal('Tarantula', [no, no, no, no, no, no, no, yes, no]).
animal('Tiger', [yes, no, yes, no, no, yes, yes, no, yes]).
animal('Tiger Beetle', [no, no, no, no, no, no, yes, yes, no]).
animal('Tiger Snake', [no, no, yes, no, no, no, yes, no, yes]).
animal('Toucan', [no, no, no, yes, no, yes, no, no, no]).
animal('Triggerfish', [no, yes, no, no, no, yes, yes, no, yes]).
animal('Turtle', [no, yes, yes, no, no, yes, no, no, no]).
animal('Verreaux', [no, no, yes, yes, no, yes, no, no, yes]).
animal('Vulture', [no, no, yes, yes, no, no, yes, no, no]).
animal('Wandering Spider', [no, no, no, yes, no, no, no, yes, no]).
animal('Wasp', [no, no, yes, yes, no, no, yes, yes, yes]).
animal('White-Backed Vulture', [no, no, yes, yes, yes, yes, no, no, yes]).
animal('Wildebeest', [yes, no, no, yes, yes, yes, yes, no, no]).
animal('Wolf', [yes, no, yes, no, yes, no, no, no, no]).
animal('Wolverine', [yes, no, yes, no, yes, no, no, yes, yes]).
animal('Yellow-Billed Stork', [no, no, yes, yes, yes, yes, yes, yes, no]).
animal('Zebra', [yes, no, no, no, no, yes, yes, no, no]).
animal('Zorilla', [yes, no, no, no, yes, yes, yes, yes, no]).

% Основной цикл игры
play :-
    nl,
    retractall(answer(_, _, _)),
    retractall(incorrect_guess),
    ask_questions([]).

% Задавание вопросов
ask_questions(Answers) :-
    length(Answers, _NumAnswers),
    findall(QID, (question(QID, _, _), \+ member(answer(QID, _), Answers)), QIDs),
    (   QIDs = [] ->  % Если вопросов больше нет
        learn_new_animal(Answers)
    ;   incorrect_guess ->  % Если было неверное предположение
        select_next_question(Answers, QuestionID, QuestionText),
        ask_question(QuestionID, QuestionText, Answers)
    ;   findall(Animal, matches(Animal, Answers), Candidates),
        (   Candidates = [Animal] ->  % Если остался один кандидат
            make_guess(Animal, Answers)
        ;   Candidates = [] ->  % Если кандидатов нет
            learn_new_animal(Answers)
        ;   select_next_question(Answers, QuestionID, QuestionText),
            ask_question(QuestionID, QuestionText, Answers)
        )
    ).

% Проверка соответствия животного ответам
matches(Animal, Answers) :-
    animal(Animal, Features),
    check_answers(Answers, Features).

check_answers([], _).
check_answers([answer(QID, Ans)|Rest], Features) :-
    nth1(QID, Features, Ans),
    check_answers(Rest, Features).

% Выбор следующего вопроса
select_next_question(Answers, QID, Text) :-
    findall(QID, (question(QID, _, _), \+ member(answer(QID, _), Answers)), QIDs),
    QIDs = [QID|_],  % Берем первый доступный вопрос
    question(QID, Text, _).

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
    (   Confirm = yes ->
        write('Отлично! Я угадал!'), nl
    ;   Confirm = no ->
        assertz(incorrect_guess),  % Отмечаем, что было неверное предположение
        ask_questions(Answers)
    ;   write('Пожалуйста, введите yes или no.'), nl,
        make_guess(Animal, Answers)
    ).

% Обучение новому животному
learn_new_animal(Answers) :-
    write('Сообщение: Как называется ваше животное?'), nl,
    read(NewAnimal),
    (   atom(NewAnimal) ->
        findall(Animal, matches(Animal, Answers), Candidates),
        (   Candidates = [ExistingAnimal] ->
            add_new_question(Answers, NewAnimal, ExistingAnimal)
        ;   build_features(Answers, Features),
            assertz(animal(NewAnimal, Features)),
            save_animal(NewAnimal, Features),
            write('Спасибо! Я запомнил животное '), write(NewAnimal), write('.'), nl,
            write('Игра завершена.'), nl
        )
    ;   write('Пожалуйста, введите корректное имя животного (в одинарных кавычках, например, ''Tiger'').'), nl,
        learn_new_animal(Answers)
    ).

% Построение списка характеристик
build_features(Answers, Features) :-
    findall(Ans, (
        between(1, 9, QID),
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

% Вспомогательные предикаты
opposite_answer(yes, no).
opposite_answer(no, yes).

get_max_question_id(MaxID) :-
    findall(ID, question(ID, _, _), IDs),
    (IDs = [] -> MaxID = 0; max_list(IDs, MaxID)).

save_animal(NewAnimal, Features) :-
    catch(
        (   open('akinator.pl', append, Stream),
            write(Stream, 'animal(\''),
            writeq(Stream, NewAnimal),
            write(Stream, '\', '),
            writeq(Stream, Features),
            write(Stream, ').\n'),
            close(Stream),
            write('Животное '), write(NewAnimal), write(' успешно сохранено.'), nl
        ),
        Error,
        (   write('Ошибка при сохранении животного: '), write(Error), nl,
            fail
        )
    ).

save_question(QID, QuestionText) :-
    catch(
        (   open('akinator.pl', append, Stream),
            write(Stream, 'question('),
            write(Stream, QID),
            write(Stream, ', '),
            writeq(Stream, QuestionText),
            write(Stream, ', [yes, no]).\n'),
            close(Stream),
            write('Вопрос '), write(QID), write(' успешно сохранен.'), nl
        ),
        Error,
        (   write('Ошибка при сохранении вопроса: '), write(Error), nl,
            fail
        )
    ).

save_characteristic(QID, Animal, Answer) :-
    catch(
        (   open('akinator.pl', append, Stream),
            write(Stream, 'characteristic('),
            write(Stream, QID),
            write(Stream, ', '),
            writeq(Stream, Animal),
            write(Stream, ', '),
            write(Stream, Answer),
            write(Stream, ').\n'),
            close(Stream),
            write('Характеристика для '), write(Animal), write(' успешно сохранена.'), nl
        ),
        Error,
        (   write('Ошибка при сохранении характеристики: '), write(Error), nl,
            fail
        )
    ).
    
 
animal('dsfndshds', [yes,yes,yes,no,no,no,no,no,no]).
