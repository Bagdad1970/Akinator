:- dynamic possible_animal/1.
:- dynamic key_answer/2. 
:- encoding(utf8).
:- consult('animals.pl').

% Define questions in order of generality
question(mammal, 'Является ли животное млекопитающим? (1-да, 0-нет)', [0, 1]).
question(land, 'Обитает ли животное на суше? (1-да, 0-нет, 2-и то и другое)', [0, 1, 2]).
question(domestic_animal, 'Является ли животное домашним? (1-да, 0-нет)', [0, 1]).
question(plant_pollinator, 'Является ли животное опылителем растений? (1-да, 0-нет)', [0, 1]).
question(wings, 'Имеет ли животное крылья? (1-да, 0-нет)', [0, 1]).
question(lives_in_groups, 'Живёт ли животное в группах? (1->3 особи, 2-пары, 0-одиночное)', [0, 1, 2]).
question(amphibian, 'Является ли животное земноводным? (1-да, 0-нет)', [0, 1]).
question(diet, 'Какой тип питания у животного? (0-травоядное, 1-хищник, 2-всеядное)', [0, 1, 2]).
question(predator, 'Является ли животное хищником? (1-да, 0-нет)', [0, 1]).
question(stripes, 'Имеет ли животное полосы на теле? (1-да, 0-нет)', [0, 1]).
question(large_animal, 'Является ли животное крупным? (1-да, 0-нет)', [0, 1]).
question(scales, 'Имеет ли животное чешую? (1-да, 0-нет)', [0, 1]).
question(fur, 'Имеет ли животное шерсть? (1-да, 0-нет)', [0, 1]).
question(can_fly, 'Умеет ли животное летать? (1-да, 0-нет)', [0, 1]).
question(venomous, 'Является ли животное ядовитым? (1-да, 0-нет)', [0, 1]).
question(insect, 'Является ли животное насекомым? (1-да, 0-нет)', [0, 1]).
question(farmed, 'Разводят на фермах? (1-да, 0-нет)', [0, 1]).
question(aquarium_species, 'Можно увидеть в океанариуме? (1-да, 0-нет)', [0, 1]).
question(reptile, 'Является рептилией? (1-да, 0-нет)', [0, 1]).
question(feline, 'Принадлежит к семейству кошачьих? (1-да, 0-нет)', [0, 1]).
question(tail, 'Имеет ли животное хвост? (1-да, 0-нет)', [0, 1]).
question(climbs_trees, 'Умеет лазить по деревьям? (1-да, 0-нет)', [0, 1]).
question(warm_blooded, 'Является ли животное теплокровным? (1-да, 0-нет)', [0, 1]).
question(used_in_agriculture, 'Используется ли животное в сельском хозяйстве или транспорте? (1-да, 0-нет)', [0, 1]).
question(hibernates_in_winter, 'Впадает ли животное в зимнюю спячку? (1-да, 0-нет)', [0, 1]).
question(trunk, 'Имеет хобот? (1-да, 0-нет)', [0, 1]).
question(nocturnal, 'Ведёт ночной образ жизни? (1-да, 0-нет)', [0, 1]).
question(elongated_body, 'Имеет длинное змеевидное тело? (1-да, 0-нет)', [0, 1]).
question(marine, 'Обитает в морской воде? (1-да, 0-нет)', [0, 1]).
question(used_for_carrying_loads, 'Используется ли животное для переноски грузов? (1-да, 0-нет)', [0, 1]).
question(bright_coloring, 'Имеет ли животное яркую окраску? (1-да, 0-нет)', [0, 1]).
question(marsupial, 'Является ли животное сумчатым? (1-да, 0-нет)', [0, 1]).
question(long_neck, 'Имеет ли животное длинную шею? (1-да, 0-нет)', [0, 1]).
question(long_ears, 'Имеет ли животное длинные уши? (1-да, 0-нет)', [0, 1]).
question(ornamental, 'Является ли рыба декоративной? (1-да, 0-нет)', [0, 1]).
question(lives_near_water, 'Обитает ли животное возле водоёмов? (1-да, 0-нет)', [0, 1]).
question(long_sword_like_snout, 'Имеет мечевидный вырост на морде? (1-да, 0-нет)', [0, 1]).
question(saw_like_projection_with_teeth, 'Имеет пилообразный вырост с зубцами? (1-да, 0-нет)', [0, 1]).
question(eats_bamboo, 'Питается ли животное преимущественно бамбуком? (1-да, 0-нет)', [0, 1]).
question(largest_animal, 'Является самым крупным животным? (1-да, 0-нет)', [0, 1]).
question(fastest_bird, 'Является ли животное одной из самых быстрых птиц? (1-да, 0-нет)', [0, 1]).
question(forest_hunting_bird, 'Охотится ли животное преимущественно в лесах? (1-да, 0-нет)', [0, 1]).
question(wingspan_over_2_meters, 'Имеет ли животное размах крыльев более 2 метров? (1-да, 0-нет)', [0, 1]).
question(long_colorful_tail_with_eye, 'Имеет ли животное длинный хвост с глазчатыми пятнами? (1-да, 0-нет)', [0, 1]).
question(lives_in_coral_reefs, 'Обитает ли животное в коралловых рифах? (1-да, 0-нет)', [0, 1]).
question(produces_milk, 'Даёт ли животное молоко? (1-да, 0-нет)', [0, 1]).
question(single_horn, 'Имеет ли животное рога? (1-да, 0-нет)', [0, 1]).
question(two_horns, 'Имеет ли животное два рога? (1-да, 0-нет)', [0, 1]).
question(t_shaped_head, 'Имеет T-образную голову? (1-да, 0-нет)', [0, 1])

% Define relevant questions for specific categories
relevant_questions(insect, [
    plant_pollinator, wings, lives_in_groups, diet, predator, venomous,
    bright_coloring, nocturnal, climbs_trees, ornamental
]).
relevant_questions(_, All) :- % Default: all questions are relevant
    findall(Pred, question(Pred, _, _), All).

% Main predicate to start the game
start :-
    retractall(key_answer(_, _)),
    write('Загадайте животное и отвечайте на вопросы (вводите число и точку, например, 1.).'), nl,
    retractall(possible_animal(_)),
    findall(Animal, (
        mammal(Animal, _); land(Animal, _); domestic_animal(Animal, _); plant_pollinator(Animal, _);
        wings(Animal, _); lives_in_groups(Animal, _); amphibian(Animal, _); diet(Animal, _);
        predator(Animal, _); stripes(Animal, _); large_animal(Animal, _); scales(Animal, _);
        fur(Animal, _); can_fly(Animal, _); venomous(Animal, _); insect(Animal, _);
        farmed(Animal, _); aquarium_species(Animal, _); reptile(Animal, _); feline(Animal, _);
        tail(Animal, _); climbs_trees(Animal, _); warm_blooded(Animal, _); used_in_agriculture(Animal, _);
        hibernates_in_winter(Animal, _); trunk(Animal, _); nocturnal(Animal, _); elongated_body(Animal, _);
        marine(Animal, _); used_for_carrying_loads(Animal, _); bright_coloring(Animal, _); marsupial(Animal, _);
        long_neck(Animal, _); long_ears(Animal, _); ornamental(Animal, _); lives_near_water(Animal, _);
        long_sword_like_snout(Animal, _); saw_like_projection_with_teeth(Animal, _); eats_bamboo(Animal, _);
        largest_animal(Animal, _); fastest_bird(Animal, _); forest_hunting_bird(Animal, _);
        wingspan_over_2_meters(Animal, _); long_colorful_tail_with_eye(Animal, _); lives_in_coral_reefs(Animal, _);
        produces_milk(Animal, _); single_horn(Animal, _); two_horns(Animal, _)
    ), Animals),
    list_to_set(Animals, UniqueAnimals),
    length(UniqueAnimals, N),
    (   N = 0 ->
        write('Ошибка: база данных пуста или некорректна!'), nl, halt
    ;   assert_possible_animals(UniqueAnimals),
        findall(Pred-Quest-Answ, question(Pred, Quest, Answ), Questions),
        play_akinator(Questions)
    ).

% Assert possible animals
assert_possible_animals([]).
assert_possible_animals([Animal|Rest]) :-
    assertz(possible_animal(Animal)),
    assert_possible_animals(Rest).

% Main game loop with list of remaining questions
play_akinator([]) :-
    findall(Animal, possible_animal(Animal), PossibleAnimals),
    length(PossibleAnimals, N),
    (   N = 0 ->
        write('Ни одно животное не соответствует вашим ответам.'), nl, halt
    ;   N = 1 ->
        PossibleAnimals = [Animal],
        write('Я думаю, вы загадали: '), write(Animal), write('.'), nl, halt
    ;   write('Вопросы закончились. Возможные варианты:'), nl,
        write_animals(PossibleAnimals),
        halt
    ).
play_akinator([Pred-Question-Answers|Rest]) :-
    % Check if the question is relevant based on key answers
    (   key_answer(Category, _), relevant_questions(Category, RelevantPreds), member(Pred, RelevantPreds)
    ;   \+ key_answer(_, _)
    ),
    findall(Animal, possible_animal(Animal), PossibleAnimals),
    length(PossibleAnimals, N),
    (   N = 0 ->
        write('Ни одно животное не соответствует вашим ответам.'), nl, halt
    ;   N = 1 ->
        PossibleAnimals = [Animal],
        write('Я думаю, вы загадали: '), write(Animal), write('.'), nl, halt
    ;   ask_question(Pred, Question, Answers, UserAnswer),
        % Store key answers (e.g., insect = 1)
        (   member(Pred, [mammal, insect, reptile, feline]) ->
            assertz(key_answer(Pred, UserAnswer))
        ;   true
        ),
        filter_animals(Pred, UserAnswer, Removed),
        play_akinator(Rest)
    ).
play_akinator([_|Rest]) :-
    % Skip irrelevant question
    play_akinator(Rest).

% Ask a question and get user input
ask_question(Predicate, Question, Answers, UserAnswer) :-
    write(Question), nl,
    write('Введите ответ: '), read(UserAnswer),
    (   member(UserAnswer, Answers) ->
        true
    ;   write('Некорректный ответ. Пожалуйста, введите одно из: '), write(Answers), nl,
        ask_question(Predicate, Question, Answers, UserAnswer)
    ).

% Filter animals based on user answer, return number of removed animals
filter_animals(mammal, 1, RemovedCount) :-
    !,
    findall(Animal, (
        possible_animal(Animal),
        (   \+ mammal(Animal, 1);
            insect(Animal, 1);
            wings(Animal, 1);
            can_fly(Animal, 1)
        )
    ), AnimalsToRemove),
    length(AnimalsToRemove, RemovedCount),
    retract_animals(AnimalsToRemove).
filter_animals(insect, 1, RemovedCount) :-
    !,
    findall(Animal, (
        possible_animal(Animal),
        (   \+ insect(Animal, 1);
            mammal(Animal, 1);
            reptile(Animal, 1);
            amphibian(Animal, 1);
            feline(Animal, 1);
            fur(Animal, 1);
            tail(Animal, 1);
            produces_milk(Animal, 1);
            single_horn(Animal, 1);
            two_horns(Animal, 1);
            used_in_agriculture(Animal, 1);
            used_for_carrying_loads(Animal, 1);
            eats_bamboo(Animal, 1);
            largest_animal(Animal, 1);
            long_neck(Animal, 1);
            long_ears(Animal, 1);
            trunk(Animal, 1);
            long_sword_like_snout(Animal, 1);
            saw_like_projection_with_teeth(Animal, 1)
        )
    ), AnimalsToRemove),
    length(AnimalsToRemove, RemovedCount),
    retract_animals(AnimalsToRemove).
filter_animals(Predicate, Answer, RemovedCount) :-
    findall(Animal, (
        possible_animal(Animal),
        \+ call(Predicate, Animal, Answer)
    ), AnimalsToRemove),
    length(AnimalsToRemove, RemovedCount),
    retract_animals(AnimalsToRemove).

% Retract animals that don’t match
retract_animals([]).
retract_animals([Animal|Rest]) :-
    retract(possible_animal(Animal)),
    retract_animals(Rest).

% Write remaining animals
write_animals([]).
write_animals([Animal|Rest]) :-
    write('- '), write(Animal), nl,
    write_animals(Rest).
