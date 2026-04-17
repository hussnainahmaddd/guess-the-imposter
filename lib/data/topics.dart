import '../models/topic.dart';

class TopicRepository {
  static const List<Topic> _allTopics = [
    // --- FUNNY / GROSS ---
    Topic(themeId: 'funny', common: 'What sound does a fart make?', imposter: 'What sound does a sneeze make?'),
    Topic(themeId: 'funny', common: 'What would you find in a trash can?', imposter: 'What would you find in a recycling bin?'),
    Topic(themeId: 'funny', common: 'What does a burp smell like?', imposter: 'What does a yawn feel like?'),
    Topic(themeId: 'funny', common: 'What would happen if you ate a booger?', imposter: 'What would happen if you ate a gummy worm?'),
    Topic(themeId: 'funny', common: 'What is the grossest thing you can step on barefoot?', imposter: 'What is the most uncomfortable thing you can step on barefoot?'),
    Topic(themeId: 'funny', common: "What noise does a pig make when it's happy?", imposter: "What noise does a dog make when it's happy?"),
    Topic(themeId: 'funny', common: 'What does a sweaty gym smell like?', imposter: 'What does a swimming pool smell like?'),
    Topic(themeId: 'funny', common: 'How would you describe mud between your toes?', imposter: 'How would you describe sand between your toes?'),
    Topic(themeId: 'funny', common: 'What is the weirdest thing someone could eat on a dare?', imposter: 'What is the weirdest thing someone could drink on a dare?'),
    Topic(themeId: 'funny', common: 'What would make someone gag at the dinner table?', imposter: 'What would make someone laugh at the dinner table?'),
    Topic(themeId: 'funny', common: 'What happens when you don\'t shower for a week?', imposter: 'What happens when you don\'t comb your hair for a week?'),
    Topic(themeId: 'funny', common: 'What is a funny word for going to the bathroom?', imposter: 'What is a funny word for being very tired?'),
    Topic(themeId: 'funny', common: 'What does it feel like to sit on a whoopee cushion?', imposter: 'What does it feel like to sit on a beanbag chair?'),
    Topic(themeId: 'funny', common: 'What gross prank would you pull on a friend?', imposter: 'What harmless prank would you pull on a friend?'),
    Topic(themeId: 'funny', common: 'What is the most disgusting food combo you can imagine?', imposter: 'What is the most bizarre food combo you can imagine?'),

    // --- SPACE ---
    Topic(themeId: 'space', common: 'What does it feel like to float in zero gravity?', imposter: 'What does it feel like to swim underwater?'),
    Topic(themeId: 'space', common: 'What would you pack for a trip to Mars?', imposter: 'What would you pack for a trip to the Moon?'),
    Topic(themeId: 'space', common: 'What color is a black hole?', imposter: 'What color is a neutron star?'),
    Topic(themeId: 'space', common: 'How do astronauts sleep in space?', imposter: 'How do astronauts eat in space?'),
    Topic(themeId: 'space', common: 'What would Earth look like from the Moon?', imposter: 'What would Earth look like from Mars?'),
    Topic(themeId: 'space', common: 'What is the biggest planet in our solar system?', imposter: 'What is the smallest planet in our solar system?'),
    Topic(themeId: 'space', common: 'What does a rocket launch sound like up close?', imposter: 'What does a rocket landing sound like up close?'),
    Topic(themeId: 'space', common: 'How long would it take to travel to the nearest star?', imposter: 'How long would it take to travel to the nearest planet?'),
    Topic(themeId: 'space', common: 'What would you see in the night sky without light pollution?', imposter: 'What would you see in the night sky from a mountaintop?'),
    Topic(themeId: 'space', common: 'What is the surface of the Moon like?', imposter: 'What is the surface of Mars like?'),
    Topic(themeId: 'space', common: 'What would you name a newly discovered planet?', imposter: 'What would you name a newly discovered moon?'),
    Topic(themeId: 'space', common: 'Why is space completely silent?', imposter: 'Why is the deep ocean almost completely silent?'),
    Topic(themeId: 'space', common: 'What do astronauts miss most about Earth?', imposter: 'What do deep-sea divers miss most about the surface?'),
    Topic(themeId: 'space', common: 'How do stars die?', imposter: 'How do stars form?'),
    Topic(themeId: 'space', common: 'What would you do first if you landed on an alien planet?', imposter: 'What would you do first if you discovered a new island on Earth?'),

    // --- SPOOKY ---
    Topic(themeId: 'spooky', common: 'What noise does a haunted house make at night?', imposter: 'What noise does an old abandoned mansion make during the day?'),
    Topic(themeId: 'spooky', common: 'Where would a ghost most likely live?', imposter: 'Where would a witch most likely live?'),
    Topic(themeId: 'spooky', common: "What would a vampire's bedroom look like?", imposter: "What would a werewolf's bedroom look like?"),
    Topic(themeId: 'spooky', common: 'How would you feel walking through a graveyard at midnight?', imposter: 'How would you feel walking through a dark forest at midnight?'),
    Topic(themeId: 'spooky', common: 'What do you do if you see a ghost?', imposter: 'What do you do if you hear a ghost?'),
    Topic(themeId: 'spooky', common: 'What makes a full moon scary?', imposter: 'What makes a solar eclipse eerie?'),
    Topic(themeId: 'spooky', common: "What would you find in a witch's cauldron?", imposter: "What would you find in a wizard's cauldron?"),
    Topic(themeId: 'spooky', common: 'How do zombies move?', imposter: 'How do mummies move?'),
    Topic(themeId: 'spooky', common: 'What does a haunted mirror show?', imposter: 'What does a magic mirror show?'),
    Topic(themeId: 'spooky', common: 'What would you do if your house was haunted?', imposter: "What would you do if your neighbor's house was haunted?"),
    Topic(themeId: 'spooky', common: 'What smell would a haunted mansion have?', imposter: 'What smell would an old church have?'),
    Topic(themeId: 'spooky', common: 'What power does Dracula have?', imposter: "What power does Frankenstein's monster have?"),
    Topic(themeId: 'spooky', common: 'What is the most frightening thing about a dark basement?', imposter: 'What is the most frightening thing about a dark attic?'),
    Topic(themeId: 'spooky', common: 'What would a ghost say to scare you?', imposter: 'What would a clown say to scare you?'),
    Topic(themeId: 'spooky', common: 'How do you banish an evil spirit?', imposter: 'How do you protect your home from evil spirits?'),

    // --- JUNGLE ---
    Topic(themeId: 'jungle', common: 'What sound would you hear first thing in the morning in a jungle?', imposter: 'What sound would you hear first thing in the morning on a savanna?'),
    Topic(themeId: 'jungle', common: 'What would you build to survive overnight in the jungle?', imposter: 'What would you build to survive overnight in the desert?'),
    Topic(themeId: 'jungle', common: 'What does a jungle smell like after heavy rain?', imposter: 'What does a forest smell like after heavy rain?'),
    Topic(themeId: 'jungle', common: 'What animal would you least want to encounter on a jungle path?', imposter: 'What animal would you least want to encounter on a mountain trail?'),
    Topic(themeId: 'jungle', common: 'How do monkeys communicate with each other?', imposter: 'How do gorillas communicate with each other?'),
    Topic(themeId: 'jungle', common: 'What do you do if you spot a jaguar nearby?', imposter: 'What do you do if you spot a leopard nearby?'),
    Topic(themeId: 'jungle', common: 'What color are most poisonous jungle frogs?', imposter: 'What color are most venomous jungle snakes?'),
    Topic(themeId: 'jungle', common: 'How thick is the jungle canopy above you?', imposter: 'How thick is a rainforest understory around you?'),
    Topic(themeId: 'jungle', common: 'What would you eat if you were lost in the jungle for a week?', imposter: 'What would you eat if you were lost in a forest for a week?'),
    Topic(themeId: 'jungle', common: 'What insects are most dangerous in the Amazon jungle?', imposter: 'What insects are most dangerous in Southeast Asian jungles?'),
    Topic(themeId: 'jungle', common: 'How do plants in the jungle compete for sunlight?', imposter: 'How do plants in the jungle compete for water?'),
    Topic(themeId: 'jungle', common: 'What does it feel like to walk through dense jungle undergrowth?', imposter: 'What does it feel like to wade through a shallow jungle river?'),
    Topic(themeId: 'jungle', common: 'Why do jaguars have spotted coats?', imposter: 'Why do tigers have striped coats?'),
    Topic(themeId: 'jungle', common: 'What would a river in the Amazon look like?', imposter: 'What would a river in the Congo jungle look like?'),
    Topic(themeId: 'jungle', common: 'How would you find water in a jungle without a map?', imposter: 'How would you find water in a desert without a map?'),

    // --- FOOD ---
    Topic(themeId: 'food', common: 'What does a freshly baked pizza smell like?', imposter: 'What does a freshly baked bread smell like?'),
    Topic(themeId: 'food', common: 'How do you eat a burger without it falling apart?', imposter: 'How do you eat a taco without it falling apart?'),
    Topic(themeId: 'food', common: 'What is the crunchiest food you can think of?', imposter: 'What is the chewiest food you can think of?'),
    Topic(themeId: 'food', common: 'Why does sushi taste better with soy sauce?', imposter: 'Why does sushi taste better with wasabi?'),
    Topic(themeId: 'food', common: 'What makes a good chocolate cake?', imposter: 'What makes a good vanilla cake?'),
    Topic(themeId: 'food', common: 'How do you know when pasta is perfectly cooked?', imposter: 'How do you know when rice is perfectly cooked?'),
    Topic(themeId: 'food', common: 'What is the most satisfying food to eat on a cold day?', imposter: 'What is the most satisfying food to eat on a hot day?'),
    Topic(themeId: 'food', common: 'Why do onions make you cry?', imposter: 'Why do spicy peppers make your eyes water?'),
    Topic(themeId: 'food', common: 'How would you describe the texture of fresh mozzarella?', imposter: 'How would you describe the texture of fresh ricotta?'),
    Topic(themeId: 'food', common: 'What food looks the most fun to cook?', imposter: 'What food looks the most fun to eat?'),
    Topic(themeId: 'food', common: 'How does street food taste different from restaurant food?', imposter: 'How does homemade food taste different from restaurant food?'),
    Topic(themeId: 'food', common: 'What is the weirdest food combination that actually works?', imposter: 'What is the weirdest food combination that definitely does not work?'),
    Topic(themeId: 'food', common: 'How do you eat ice cream without it melting everywhere?', imposter: 'How do you eat gelato without it melting everywhere?'),
    Topic(themeId: 'food', common: 'What does cooking garlic in butter smell like?', imposter: 'What does cooking garlic in olive oil smell like?'),
    Topic(themeId: 'food', common: 'What topping ruins a pizza for you?', imposter: 'What topping ruins a salad for you?'),
  ];

  static Topic getRandomTopic(String themeId) {
    final themeTopics = _allTopics.where((t) => t.themeId == themeId).toList();
    if (themeTopics.isEmpty) {
      // Fallback
      return const Topic(themeId: 'none', common: 'How many fingers do you have?', imposter: 'How many toes do you have?');
    }
    return (themeTopics..shuffle()).first;
  }
}
