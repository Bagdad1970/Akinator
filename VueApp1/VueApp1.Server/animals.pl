:- dynamic animal/2, question/3.

question(1, 'Является ли животное млекопитающим?', [yes,no]).
question(2, 'Живет ли животное в воде?', [yes,no]).
question(3, 'Является ли животное хищником?', [yes,no]).
question(4, 'Умеет ли животное летать?', [yes,no]).
question(5, 'Живет ли животное в Арктике?', [yes,no]).
question(6, 'Живет ли животное в Африке?', [yes,no]).
question(7, '�\x98\меет ли животное полосы?', [yes,no]).
question(8, 'Является ли животное ядовитым?', [yes,no]).
question(9, '�\x98\меет ли животное рыжий окрас?', [yes,no]).

animal('African Fish Eagle', [1-no,2-no,3-yes,4-yes,5-no,6-yes,7-no,8-no,9-no]).
animal('Angelfish', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-yes,8-no,9-no]).
animal('Ant', [1-no,2-no,3-yes,4-no,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Arctic Cod', [1-no,2-yes,3-yes,4-no,5-yes,6-no,7-no,8-no,9-no]).
animal('Arctic Skua', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-yes,8-no,9-no]).
animal('Arctic Tern', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-no,8-no,9-no]).
animal('Banded Mongoose', [1-yes,2-no,3-yes,4-no,5-no,6-no,7-yes,8-no,9-no]).
animal('Barracuda', [1-no,2-yes,3-yes,4-no,5-no,6-yes,7-yes,8-no,9-no]).
animal('Bat-Eared Fox', [1-yes,2-no,3-yes,4-yes,5-no,6-yes,7-no,8-no,9-yes]).
animal('Bear', [1-yes,2-no,3-yes,4-no,5-no,6-no,7-no,8-no,9-no]).
animal('Beluga Whale', [1-yes,2-yes,3-yes,4-no,5-yes,6-no,7-no,8-no,9-no]).
animal('Black Mamba', [1-no,2-no,3-yes,4-no,5-no,6-yes,7-no,8-yes,9-no]).
animal('Blue-Ringed Octopus', [1-no,2-yes,3-yes,4-no,5-no,6-no,7-no,8-yes,9-yes]).
animal('Bowhead Whale', [1-yes,2-yes,3-no,4-no,5-yes,6-no,7-no,8-no,9-no]).
animal('Box Jellyfish', [1-no,2-yes,3-yes,4-no,5-no,6-yes,7-no,8-yes,9-no]).
animal('Brazilian Wandering Spider', [1-no,2-no,3-yes,4-no,5-no,6-no,7-yes,8-yes,9-no]).
animal('Cancer', [1-no,2-yes,3-yes,4-no,5-yes,6-yes,7-no,8-no,9-yes]).
animal('Cape Buffalo', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-yes,8-no,9-no]).
animal('Cape Cobra', [1-no,2-no,3-yes,4-no,5-no,6-yes,7-yes,8-yes,9-yes]).
animal('Capelin', [1-no,2-yes,3-yes,4-no,5-yes,6-no,7-no,8-no,9-yes]).
animal('Caracal', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-yes,8-yes,9-no]).
animal('Cheetah', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Clownfish', [1-no,2-yes,3-no,4-no,5-no,6-no,7-yes,8-no,9-yes]).
animal('Coral Snake', [1-no,2-no,3-yes,4-no,5-no,6-no,7-yes,8-yes,9-yes]).
animal('Cow', [1-yes,2-no,3-no,4-no,5-no,6-no,7-no,8-no,9-no]).
animal('Crane', [1-no,2-yes,3-no,4-yes,5-no,6-yes,7-no,8-no,9-no]).
animal('Crocodile', [1-no,2-no,3-yes,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Dog', [1-yes,2-no,3-yes,4-no,5-no,6-no,7-no,8-no,9-yes]).
animal('Dolphin', [1-yes,2-yes,3-yes,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Duck', [1-no,2-no,3-no,4-yes,5-no,6-no,7-no,8-no,9-no]).
animal('Eagle', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-no,8-no,9-no]).
animal('Emu', [1-no,2-no,3-no,4-no,5-no,6-no,7-no,8-no,9-yes]).
animal('Fennec Fox', [1-yes,2-no,3-yes,4-no,5-yes,6-yes,7-no,8-no,9-yes]).
animal('Firefly', [1-no,2-no,3-no,4-yes,5-yes,6-yes,7-no,8-no,9-no]).
animal('Fisher', [1-no,2-no,3-yes,4-no,5-yes,6-no,7-yes,8-yes,9-no]).
animal('Flamingo', [1-no,2-yes,3-no,4-yes,5-no,6-yes,7-no,8-no,9-yes]).
animal('Frog', [1-no,2-yes,3-yes,4-no,5-no,6-yes,7-no,8-yes,9-no]).
animal('Gaboon Viper', [1-no,2-no,3-yes,4-no,5-yes,6-yes,7-no,8-yes,9-yes]).
animal('Gila Monster', [1-no,2-no,3-yes,4-no,5-no,6-no,7-no,8-yes,9-no]).
animal('Giraffe', [1-yes,2-no,3-no,4-no,5-no,6-yes,7-yes,8-no,9-yes]).
animal('Greenland Shark', [1-no,2-yes,3-yes,4-no,5-yes,6-no,7-yes,8-no,9-no]).
animal('Gyrfalcon', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-yes,8-no,9-yes]).
animal('Hare', [1-yes,2-no,3-no,4-no,5-yes,6-no,7-no,8-no,9-yes]).
animal('Hawk', [1-no,2-no,3-yes,4-yes,5-no,6-yes,7-yes,8-no,9-no]).
animal('Hawk Moth', [1-no,2-no,3-no,4-yes,5-no,6-no,7-no,8-no,9-yes]).
animal('Honey Badger', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-yes,8-yes,9-yes]).
animal('Hooded Seal', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-no,8-yes,9-no]).
animal('Horned Viper', [1-no,2-no,3-no,4-yes,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Hornet', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-yes,8-yes,9-no]).
animal('Horse', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-no,8-no,9-no]).
animal('Humpback Whale', [1-yes,2-yes,3-no,4-no,5-yes,6-yes,7-yes,8-no,9-no]).
animal('Hyena', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-yes,8-no,9-no]).
animal('Impala', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-yes,8-no,9-yes]).
animal('Inland Taipan', [1-no,2-no,3-yes,4-no,5-no,6-no,7-no,8-yes,9-yes]).
animal('Ivory Gull', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-yes,8-yes,9-no]).
animal('Jackal', [1-yes,2-no,3-yes,4-no,5-yes,6-yes,7-no,8-no,9-no]).
animal('Jaeger', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-no,8-yes,9-no]).
animal('Jellyfish', [1-no,2-yes,3-no,4-no,5-yes,6-yes,7-no,8-yes,9-no]).
animal('Kea', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-no,8-no,9-yes]).
animal('King Cobra', [1-no,2-no,3-no,4-no,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Kittiwake', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-yes,8-yes,9-yes]).
animal('Komodo Dragon', [1-no,2-no,3-yes,4-no,5-no,6-no,7-no,8-no,9-yes]).
animal('Krill', [1-no,2-yes,3-no,4-no,5-yes,6-no,7-no,8-yes,9-no]).
animal('Leopard', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-yes,8-yes,9-yes]).
animal('Lilac-Breasted Roller', [1-no,2-no,3-no,4-yes,5-no,6-yes,7-yes,8-no,9-yes]).
animal('Lion', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-no,8-no,9-yes]).
animal('Lionfish', [1-no,2-yes,3-no,4-no,5-no,6-no,7-no,8-yes,9-yes]).
animal('Lynx', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-yes,8-no,9-no]).
animal('Macaw', [1-no,2-no,3-no,4-yes,5-no,6-no,7-yes,8-no,9-yes]).
animal('Manta Ray', [1-no,2-yes,3-no,4-no,5-no,6-no,7-yes,8-no,9-no]).
animal('Marabou Stork', [1-no,2-no,3-no,4-yes,5-no,6-yes,7-yes,8-no,9-no]).
animal('Merlin', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-yes,8-yes,9-yes]).
animal('Mink', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-yes,8-yes,9-yes]).
animal('Mojave Rattlesnake', [1-no,2-no,3-yes,4-yes,5-yes,6-yes,7-no,8-yes,9-no]).
animal('Monarch Butterfly', [1-no,2-no,3-no,4-no,5-no,6-no,7-yes,8-yes,9-yes]).
animal('Monitor Lizard', [1-no,2-no,3-yes,4-no,5-no,6-no,7-yes,8-no,9-no]).
animal('Monkey', [1-yes,2-no,3-no,4-no,5-no,6-yes,7-no,8-no,9-yes]).
animal('Moray Eel', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Narwhal', [1-yes,2-no,3-no,4-no,5-yes,6-no,7-no,8-no,9-no]).
animal('Okapi', [1-yes,2-no,3-no,4-no,5-no,6-no,7-yes,8-no,9-yes]).
animal('Osprey', [1-no,2-no,3-yes,4-yes,5-yes,6-yes,7-no,8-no,9-no]).
animal('Painted Stork', [1-no,2-no,3-yes,4-yes,5-yes,6-yes,7-yes,8-no,9-no]).
animal('Parrot', [1-no,2-no,3-no,4-yes,5-no,6-no,7-yes,8-yes,9-yes]).
animal('Parrotfish', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-no,8-no,9-yes]).
animal('Peregrine Falcon', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-no,8-yes,9-yes]).
animal('Pigeon', [1-no,2-no,3-no,4-yes,5-yes,6-yes,7-no,8-no,9-no]).
animal('Polar Bear', [1-yes,2-no,3-no,4-no,5-yes,6-no,7-yes,8-yes,9-no]).
animal('Pomarine Jaeger', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-no,8-yes,9-yes]).
animal('Puff Adder', [1-no,2-no,3-no,4-no,5-yes,6-yes,7-no,8-yes,9-yes]).
animal('Pufferfish', [1-no,2-yes,3-no,4-no,5-no,6-no,7-yes,8-yes,9-yes]).
animal('Quetzal', [1-no,2-no,3-no,4-yes,5-no,6-no,7-yes,8-no,9-no]).
animal('Rat', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-no,8-no,9-yes]).
animal('Rattlesnake', [1-no,2-no,3-no,4-yes,5-yes,6-yes,7-no,8-yes,9-no]).
animal('Raven', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-yes,8-no,9-yes]).
animal('Red Wolf', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-no,8-no,9-yes]).
animal('Red kangaroo', [1-yes,2-no,3-no,4-no,5-no,6-no,7-no,8-no,9-yes]).
animal('Red-Bellied Snake', [1-no,2-no,3-no,4-no,5-no,6-yes,7-yes,8-yes,9-yes]).
animal('Red-Billed Oxpecker', [1-no,2-no,3-no,4-yes,5-yes,6-yes,7-no,8-no,9-yes]).
animal('Red-Throated Loon', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-no,8-no,9-yes]).
animal('Redback Spider', [1-no,2-no,3-no,4-no,5-no,6-no,7-no,8-yes,9-yes]).
animal('Rhinoceros', [1-yes,2-no,3-no,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Ringed Seal', [1-yes,2-no,3-no,4-no,5-yes,6-no,7-yes,8-yes,9-yes]).
animal('Rinkhals', [1-no,2-no,3-yes,4-no,5-yes,6-yes,7-no,8-yes,9-no]).
animal('Ross', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-no,8-no,9-yes]).
animal('Saddle-Billed Stork', [1-no,2-no,3-yes,4-yes,5-no,6-yes,7-yes,8-no,9-yes]).
animal('Saw-Scaled Viper', [1-no,2-no,3-yes,4-yes,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Scorpion', [1-no,2-no,3-yes,4-no,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Scorpionfish', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-yes,8-yes,9-no]).
animal('Sea Anemone', [1-no,2-yes,3-no,4-no,5-no,6-no,7-no,8-yes,9-no]).
animal('Sea Snake', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-no,8-yes,9-yes]).
animal('Shark', [1-no,2-yes,3-yes,4-no,5-yes,6-yes,7-no,8-no,9-no]).
animal('Snail', [1-no,2-no,3-no,4-no,5-no,6-no,7-no,8-no,9-no]).
animal('Snow Bunting', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-yes,8-no,9-yes]).
animal('Snow Goose', [1-no,2-no,3-no,4-yes,5-yes,6-no,7-no,8-no,9-no]).
animal('Snowy Egret', [1-no,2-no,3-yes,4-yes,5-yes,6-no,7-yes,8-yes,9-no]).
animal('Snowy Owl', [1-no,2-no,3-no,4-no,5-yes,6-no,7-no,8-yes,9-yes]).
animal('Spotted Hyena', [1-yes,2-no,3-yes,4-no,5-yes,6-yes,7-yes,8-no,9-yes]).
animal('Springbok', [1-yes,2-no,3-no,4-yes,5-yes,6-yes,7-yes,8-no,9-yes]).
animal('Stonefish', [1-no,2-yes,3-no,4-no,5-no,6-no,7-yes,8-yes,9-no]).
animal('Suricate', [1-yes,2-no,3-no,4-yes,5-yes,6-yes,7-yes,8-yes,9-yes]).
animal('Tarantula', [1-no,2-no,3-no,4-no,5-no,6-no,7-no,8-yes,9-no]).
animal('Tiger', [1-yes,2-no,3-yes,4-no,5-no,6-yes,7-yes,8-no,9-yes]).
animal('Tiger Beetle', [1-no,2-no,3-no,4-no,5-no,6-no,7-yes,8-yes,9-no]).
animal('Tiger Snake', [1-no,2-no,3-yes,4-no,5-no,6-no,7-yes,8-no,9-yes]).
animal('Toucan', [1-no,2-no,3-no,4-yes,5-no,6-yes,7-no,8-no,9-no]).
animal('Triggerfish', [1-no,2-yes,3-no,4-no,5-no,6-yes,7-yes,8-no,9-yes]).
animal('Turtle', [1-no,2-yes,3-yes,4-no,5-no,6-yes,7-no,8-no,9-no]).
animal('Verreaux', [1-no,2-no,3-yes,4-yes,5-no,6-yes,7-no,8-no,9-yes]).
animal('Vulture', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-yes,8-no,9-no]).
animal('Wandering Spider', [1-no,2-no,3-no,4-yes,5-no,6-no,7-no,8-yes,9-no]).
animal('Wasp', [1-no,2-no,3-yes,4-yes,5-no,6-no,7-yes,8-yes,9-yes]).
animal('White-Backed Vulture', [1-no,2-no,3-yes,4-yes,5-yes,6-yes,7-no,8-no,9-yes]).
animal('Wildebeest', [1-yes,2-no,3-no,4-yes,5-yes,6-yes,7-yes,8-no,9-no]).
animal('Wolf', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-no,8-no,9-no]).
animal('Wolverine', [1-yes,2-no,3-yes,4-no,5-yes,6-no,7-no,8-yes,9-yes]).
animal('Yellow-Billed Stork', [1-no,2-no,3-yes,4-yes,5-yes,6-yes,7-yes,8-yes,9-no]).
animal('Zebra', [1-yes,2-no,3-no,4-no,5-no,6-yes,7-yes,8-no,9-no]).
animal('Zorilla', [1-yes,2-no,3-no,4-no,5-yes,6-yes,7-yes,8-yes,9-no]).
