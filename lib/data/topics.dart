import '../models/topic.dart';

class TopicRepository {
  static const List<Topic> _allTopics = [
    // --- FUNNY / GROSS ---
    Topic(themeId: 'funny', common: 'How many times did you fart today?', imposter: 'How many times did you sneeze today?'),
    Topic(themeId: 'funny', common: 'How many days have you worn these underwear?', imposter: 'How many days since you showered?'),
    Topic(themeId: 'funny', common: 'How many boogers have you picked in your life?', imposter: 'How many bugs have you eaten?'),
    Topic(themeId: 'funny', common: 'How many years until you grow up?', imposter: 'How many months old are your socks?'),
    Topic(themeId: 'funny', common: 'How many times do you drool while sleeping?', imposter: 'How many times do you check your phone at night?'),
    
    // --- SPACE ---
    Topic(themeId: 'space', common: 'How many aliens live on the moon?', imposter: 'How many cheeseburgers can you eat?'),
    Topic(themeId: 'space', common: 'How many years would you survive on Mars?', imposter: 'How many minutes can you hold your breath?'),
    Topic(themeId: 'space', common: 'How many stars can you count?', imposter: 'How many jellybeans are in a jar?'),
    Topic(themeId: 'space', common: 'How many rocket launches have you seen?', imposter: 'How many times have you jumped on a trampoline?'),

    // --- SPOOKY ---
    Topic(themeId: 'spooky', common: 'How many ghosts are in this room?', imposter: 'How many people are in this room?'),
    Topic(themeId: 'spooky', common: 'How many zombies have you fought?', imposter: 'How many mosquitos have you swatted?'),
    Topic(themeId: 'spooky', common: 'How many vampires are hiding outside?', imposter: 'How many stray cats are in the neighborhood?'),
    Topic(themeId: 'spooky', common: 'How many skeletons are in your closet?', imposter: 'How many shirts are in your closet?'),

    // --- JUNGLE --- 
    Topic(themeId: 'jungle', common: 'How many monkeys are in the tree?', imposter: 'How many bananas are in the bunch?'),
    Topic(themeId: 'jungle', common: 'How many stripes does a zebra have?', imposter: 'How many keys are on a piano?'),
    Topic(themeId: 'jungle', common: 'How many lions are hunting right now?', imposter: 'How many kittens are sleeping right now?'),
    Topic(themeId: 'jungle', common: 'How many parrots are copying you?', imposter: 'How many toddlers are copying you?'),

    // --- FOOD ---
    Topic(themeId: 'food', common: 'How many pizzas can you eat in one sitting?', imposter: 'How many frisbees can you throw?'),
    Topic(themeId: 'food', common: 'How many spicy peppers can you handle?', imposter: 'How many minutes can you stare at the sun?'),
    Topic(themeId: 'food', common: 'How many donuts are in a dozen?', imposter: 'How many eggs are in a carton?'),
    Topic(themeId: 'food', common: 'How many sushi rolls did you order?', imposter: 'How many marshmallows did you eat?'),
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
