import 'package:flutter/material.dart';
import '../models/game_theme.dart';

class ThemeRepository {
  static const List<GameTheme> themes = [
    GameTheme(
      id: 'funny',
      name: 'Gross & Silly',
      description: 'Funny, gross, and weird questions. Perfect for parties!',
      avatarAssetFolder: 'assets/avatars/funny/', // Existing one
      primaryColor: Color(0xFF9C27B0), // Purple
      accentColor: Color(0xFFFFEB3B), // Yellow
      icon: Icons.emoji_emotions,
    ),
    GameTheme(
      id: 'space',
      name: 'Space Odyssey',
      description: 'Sci-fi, aliens, and cosmic mysteries.',
      avatarAssetFolder: 'assets/avatars/space/',
      primaryColor: Color(0xFF3F51B5), // Indigo
      accentColor: Color(0xFF00E5FF), // Cyan
      icon: Icons.rocket_launch,
    ),
    GameTheme(
      id: 'spooky',
      name: 'Spooky Mansion',
      description: 'Ghosts, vampires, and creepy crawlies.',
      avatarAssetFolder: 'assets/avatars/spooky/',
      primaryColor: Color(0xFF212121), // Dark Grey
      accentColor: Color(0xFFFF5252), // Red
      icon: Icons.nightlight_round,
    ),
    GameTheme(
      id: 'jungle',
      name: 'Jungle Safari',
      description: 'Wild animals, nature, and adventure.',
      avatarAssetFolder: 'assets/avatars/jungle/',
      primaryColor: Color(0xFF2E7D32), // Green
      accentColor: Color(0xFFFF9800), // Orange
      icon: Icons.pets,
    ),
    GameTheme(
      id: 'food',
      name: 'Foodie Fiesta',
      description: 'Delicious dishes, snacks, and cooking.',
      avatarAssetFolder: 'assets/avatars/food/',
      primaryColor: Color(0xFFFF5722), // Deep Orange
      accentColor: Color(0xFF8BC34A), // Light Green
      icon: Icons.lunch_dining,
    ),
  ];

  static GameTheme getTheme(String id) {
    return themes.firstWhere((t) => t.id == id, orElse: () => themes[0]);
  }
}
