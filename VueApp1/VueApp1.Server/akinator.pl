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

% Животные
animal('Elephant', [yes, no, no, no, no, yes, no, no, no]).  % Слон  
animal('Dolphin', [yes, yes, yes, no, no, no, no, no, no]).  % Дельфин  
animal('Bat', [yes, no, yes, yes, no, no, no, no, no]).      % Летучая мышь  
animal('Polar Bear', [yes, no, yes, no, yes, no, no, no, no]). % Белый медведь  
animal('Lion', [yes, no, yes, no, no, yes, no, no, yes]).     % Лев  
animal('Tiger', [yes, no, yes, no, no, no, yes, no, no]).    % Тигр  
animal('Eagle', [no, no, yes, yes, no, no, no, no, no]).     % Орёл  
animal('Shark', [no, yes, yes, no, no, no, no, no, no]).      % Акула  
animal('Giraffe', [yes, no, no, no, no, yes, no, no, no]).    % Жираф  
animal('Zebra', [yes, no, no, no, no, yes, yes, no, no]).     % Зебра  
animal('Kangaroo', [yes, no, no, no, no, no, no, no, no]).   % Кенгуру  
animal('Cobra', [no, no, yes, no, no, yes, no, yes, no]).     % Кобра  
animal('Fox', [yes, no, yes, no, no, no, no, no, yes]).      % Лиса  
animal('Octopus', [no, yes, yes, no, no, no, no, yes, no]).   % Осьминог  
animal('Flamingo', [no, no, no, yes, no, no, no, no, yes]).   % Фламинго  
animal('Hippopotamus', [yes, yes, no, no, no, yes, no, no, no]). % Бегемот  
animal('Raccoon', [yes, no, yes, no, no, no, yes, no, no]).   % Енот  
animal('Scorpion', [no, no, yes, no, no, no, no, yes, no]).   % Скорпион  
animal('Peacock', [no, no, no, yes, no, no, no, no, no]).     % Павлин  
animal('Wolf', [yes, no, yes, no, no, no, no, no, no]).         % Волк  
animal('Koala', [yes, no, no, no, no, no, no, no, no]).         % Коала  
animal('Jellyfish', [no, yes, yes, no, no, no, no, yes, no]).   % Медуза  
animal('Cheetah', [yes, no, yes, no, no, yes, yes, no, no]).     % Гепард  
animal('Owl', [no, no, yes, yes, no, no, no, no, no]).          % Сова  
animal('Seal', [yes, yes, yes, no, yes, no, no, no, no]).        % Тюлень  
animal('Rhino', [yes, no, no, no, no, yes, no, no, no]).         % Носорог  
animal('Parrot', [no, no, no, yes, no, no, no, no, yes]).       % Попугай  
animal('Panda', [yes, no, no, no, no, no, no, no, no]).         % Панда  
animal('Crocodile', [no, yes, yes, no, no, yes, no, no, no]).   % Крокодил  
animal('Gorilla', [yes, no, no, no, no, yes, no, no, no]).      % Горилла  
animal('Chimpanzee', [yes, no, no, no, no, yes, no, no, no]).   % Шимпанзе   
animal('Lemur', [yes, no, no, no, no, no, no, no, no]).         % Лемур  
animal('Walrus', [yes, yes, yes, no, yes, no, no, no, no]).      % Морж  
animal('Hedgehog', [yes, no, yes, no, no, no, no, no, no]).      % Ёж  
animal('Platypus', [yes, yes, yes, no, no, no, no, yes, no]).    % Утконос  
animal('Falcon', [no, no, yes, yes, no, no, no, no, no]).        % Сокол  
animal('Antelope', [yes, no, no, no, no, yes, no, no, no]).      % Антилопа  
animal('Armadillo', [yes, no, no, no, no, no, no, no, no]).      % Броненосец   
animal('Moose', [yes, no, no, no, yes, no, no, no, no]).         % Лось  
animal('Electric Eel', [no, yes, yes, no, no, no, no, yes, no]). % Электрический угорь  
animal('Sloth', [yes, no, no, no, no, no, no, no, no]).          % Ленивец  
animal('Toucan', [no, no, no, yes, no, no, no, no, yes]).       % Тукан   
animal('Narwhal', [yes, yes, yes, no, yes, no, no, no, no]).    % Нарвал    
animal('Manatee', [yes, yes, no, no, no, no, no, no, no]).      % Ламантин    
animal('Tasmanian Devil', [yes, no, yes, no, no, no, no, no, no]). % Тасманийский дьявол
animal('Deer', [yes, no, no, no, no, no, no, no, no]).            % Олень
animal('Frog', [no, yes, yes, no, no, no, no, yes, no]).          % Лягушка
animal('Camel', [yes, no, no, no, no, no, no, no, no]).           % Верблюд
animal('Cow', [yes, no, no, no, no, no, no, no, no]).            % Корова
animal('Pig', [yes, no, no, no, no, no, no, no, no]).            % Свинья
animal('Sheep', [yes, no, no, no, no, no, no, no, no]).          % Овца
animal('Goat', [yes, no, no, no, no, no, no, no, no]).           % Коза
animal('Chicken', [no, no, no, yes, no, no, no, no, no]).        % Курица
animal('Duck', [no, no, no, yes, no, no, no, no, no]).          % Утка
animal('Goose', [no, no, no, yes, no, no, no, no, no]).          % Гусь
animal('Rabbit', [yes, no, no, no, no, no, no, no, no]).         % Кролик
animal('Donkey', [yes, no, no, no, no, no, no, no, no]).         % Осёл
animal('Meerkat', [yes, no, yes, no, no, yes, no, no, no]).      % Сурикат
animal('Wombat', [yes, no, no, no, no, no, no, no, no]).        % Вомбат
animal('Tapir', [yes, no, no, no, no, no, no, no, no]).          % Тапир
animal('Marmot', [yes, no, no, no, no, no, no, no, no]).         % Сурок
animal('Cat', [yes, no, yes, no, no, no, no, no, no]).           % Кошка
animal('Dog', [yes, no, yes, no, no, no, no, no, no]).           % Собака
animal('Ferret', [yes, no, yes, no, no, no, no, no, no]).        % Хорёк
animal('Mouse', [yes, no, no, no, no, no, no, no, no]).          % Мышь
animal('Rat', [yes, no, no, no, no, no, no, no, no]).            % Крыса
animal('Hamster', [yes, no, no, no, no, no, no, no, no]).        % Хомяк
animal('Guinea Pig', [yes, no, no, no, no, no, no, no, no]).     % Морская свинка
animal('Chinchilla', [yes, no, no, no, no, no, no, no, no]).      % Шиншилла
animal('Gerbil', [yes, no, no, no, no, no, no, no, no]).         % Песчанка
animal('Skunk', [yes, no, yes, no, no, no, yes, no, no]).        % Скунс
animal('Horse', [yes, no, no, no, no, no, no, no, no]).         % Лошадь
animal('Mule', [yes, no, no, no, no, no, no, no, no]).          % Мул
animal('Alpaca', [yes, no, no, no, no, no, no, no, no]).         % Альпака
animal('Llama', [yes, no, no, no, no, no, no, no, no]).          % Лама
animal('Yak', [yes, no, no, no, no, no, no, no, no]).           % Як
animal('Sperm Whale', [yes, yes, yes, no, no, no, no, no, no]).   % Кашалот
animal('Turtle', [no, yes, no, no, no, no, no, no, no]).         % Черепаха
animal('Ray', [no, yes, yes, no, no, no, no, yes, no]).          % Скат
animal('Seahorse', [no, yes, no, no, no, no, no, no, no]).       % Морской конёк
animal('Otter', [yes, yes, yes, no, no, no, no, no, no]).        % Выдра
animal('Beaver', [yes, yes, no, no, no, no, no, no, no]).        % Бобр
animal('Pigeon', [no, no, no, yes, no, no, no, no, no]).         % Голубь
animal('Swan', [no, no, no, yes, no, no, no, no, no]).           % Лебедь
animal('Canary', [no, no, no, yes, no, no, no, no, yes]).        % Канарейка
animal('Mole', [yes, no, no, no, no, no, no, no, no]).          % Крот
animal('Squirrel', [yes, no, no, no, no, no, no, no, no]).       % Белка
animal('Ant', [no, no, no, no, no, no, no, no, no]).             % Муравей
animal('Bee', [no, no, no, yes, no, no, no, yes, no]).           % Пчела
animal('Butterfly', [no, no, no, yes, no, no, no, no, no]).     % Бабочка
animal('Scorpion', [no, no, yes, no, no, no, no, yes, no]).      % Скорпион
animal('Tarantula', [no, no, yes, no, no, no, no, yes, no]).     % Тарантул
animal('Ostrich', [no, no, no, no, no, no, no, no, no]).         % Страус
animal('Penguin', [no, yes, yes, no, yes, no, no, no, no]).     % Пингвин
animal('Hawk', [no, no, yes, yes, no, no, no, no, no]).          % Ястреб
animal('Woodpecker', [no, no, no, yes, no, no, no, no, no]).     % Дятел
animal('Crow', [no, no, yes, yes, no, no, no, no, no]).         % Ворона
animal('Chameleon', [no, no, yes, no, no, no, no, no, no]).      % Хамелеон
animal('Iguana', [no, no, no, no, no, no, no, no, no]).         % Игуана
animal('Salamander', [no, yes, yes, no, no, no, no, yes, no]).   % Саламандра
animal('Toad', [no, yes, yes, no, no, no, no, yes, no]).         % Жаба
animal('Alligator', [no, yes, yes, no, no, no, no, no, no]).     % Аллигатор
animal('Dingo', [yes, no, yes, no, no, no, no, no, no]).       % Динго
animal('Wallaby', [yes, no, no, no, no, no, no, no, no]).      % Валлаби
animal('Coyote', [yes, no, yes, no, no, no, no, no, no]).      % Койот
animal('Wolverine', [yes, no, yes, no, no, no, no, no, no]).   % Росомаха
animal('Badger', [yes, no, no, no, no, no, no, no, no]).          % Борсук
animal('Anteater', [yes, no, no, no, no, no, no, no, no]).       % Муравьед
animal('Firefly', [no, no, no, yes, no, no, no, no, no]).        % Светлячок
animal('Stag Beetle', [no, no, no, yes, no, no, no, no, no]).    % Жук-олень
animal('Gazelle', [yes, no, no, no, no, yes, no, no, no]).       % Газель
animal('Capybara', [yes, no, no, no, no, no, no, no, no]).       % Капибара
animal('Lynx', [yes, no, yes, no, no, no, no, no, no]).         % Рысь
animal('Wildebeest', [yes, no, no, no, no, yes, no, no, no]).   % Гну
animal('Ocelot', [yes, no, yes, no, no, no, no, no, no]).       % Оцелот
animal('Red Panda', [yes, no, no, no, no, no, no, no, no]).     % Красная панда
animal('Kea', [no, no, no, yes, no, no, no, no, yes]).          % Киа
animal('Aardvark', [yes, no, no, no, no, no, no, no, no]).      % Землеройка
animal('Binturong', [yes, no, no, no, no, no, no, no, no]).     % Бинтуронг
animal('Hyena', [yes, no, yes, no, no, no, no, no, no]).         % Гиена
animal('Shrimp', [no, yes, no, no, no, no, no, no, no]).          % Креветка
animal('Stork', [yes, no, no, yes, no, no, no, no, no]).         % Аист
animal('Kiwi', [yes, no, no, no, no, no, no, no, no]).           % Киви
animal('Gecko', [yes, no, no, no, no, no, no, no, no]).          % Геккон
animal('Crab', [no, yes, no, no, no, no, no, no, no]).           % Краб
animal('Lobster', [no, yes, no, no, no, no, no, no, no]).        % Омар
animal('Cockroach', [no, no, yes, no, no, no, no, no, no]).      % Таракан
animal('Sable', [yes, no, yes, no, no, no, no, no, no]).        % Соболь
animal('Marten', [yes, no, yes, no, no, no, no, no, no]).       % Куница
animal('Termite', [no, yes, no, no, no, no, no, no, no]).       % Термит
animal('Echidna', [yes, no, no, no, no, no, no, no, no]).        % Ехидна
animal('Buffalo', [yes, no, no, no, no, yes, no, no, no]).         % Буйвол
animal('Mongoose', [yes, no, yes, no, no, no, no, no, no]).        % Мангуста
animal('Bison', [yes, no, no, no, no, yes, no, no, no]).            % Зубр
animal('Arctic Fox', [yes, no, yes, no, yes, no, no, no, no]).     % Песец
animal('Stoat', [yes, no, yes, no, no, no, no, no, no]).           % Горностай
animal('Mandrill', [yes, no, yes, no, no, no, no, no, no]).        % Мандрил
animal('Dugong', [yes, yes, no, no, no, no, no, no, no]).          % Дюгонь
animal('Turkey', [yes, no, no, yes, no, no, no, no, no]).         % Индюк
animal('Wild Boar', [yes, no, yes, no, no, no, no, no, no]).      % Кабан
animal('Crane', [yes, no, no, yes, no, no, no, no, no]).          % Журавль
animal('Heron', [yes, no, no, yes, no, no, no, no, no]).          % Цапля
animal('Pelican', [no, yes, no, yes, no, no, no, no, no]).        % Пеликан
animal('Hare', [yes, no, no, no, no, no, no, no, no]).            % Заяц
animal('Whale', [yes, yes, no, no, no, no, no, no, no]).          % Кит
animal('Jaguar', [yes, no, yes, no, no, no, no, no, no]).         % Ягуар
animal('Sparrow', [no, no, no, yes, no, no, no, no, no]).         % Воробей
animal('Python', [yes, no, yes, no, no, no, no, no, no]).         % Питон
animal('Triton', [no, yes, no, no, no, no, no, yes, no]).         % Тритон
animal('Moray Eel', [no, yes, yes, no, no, no, no, no, no]).      % Мурена

% Основной цикл игры
play :-
    nl,
    retractall(answer(_, _, _)),
    retractall(incorrect_guess),
    ask_questions([]).

% Задавание вопросов
ask_questions(Answers) :-
    length(Answers, NumAnswers),
    (   NumAnswers >= 9 ->  % Достигнут последний вопрос
        learn_new_animal(Answers)
    ;   incorrect_guess ->  % Если уже было неверное предположение
        select_next_question(Answers, QuestionID, QuestionText),
        ask_question(QuestionID, QuestionText, Answers)
    ;   findall(Animal, matches(Animal, Answers), Candidates),
        (   Candidates = [Animal] ->  % Если остался один кандидат
            make_guess(Animal, Answers)
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
        select_next_question(Answers, QuestionID, QuestionText),
        ask_question(QuestionID, QuestionText, Answers)
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

animal('Dolphin', [yes,yes,yes,no,no,no,no,no,no]).
