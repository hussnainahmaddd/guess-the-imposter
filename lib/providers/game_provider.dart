import 'package:flutter/material.dart';
import 'dart:math';
import '../models/player.dart';
import '../models/game_theme.dart';
import '../data/topics.dart';
import '../data/themes.dart';

class GameProvider extends ChangeNotifier {
  final List<Player> _players = [];
  GameTheme _selectedTheme = ThemeRepository.themes[0];

  List<Player> get players => List.unmodifiable(_players);
  GameTheme get selectedTheme => _selectedTheme;
  
  // Basic validation: min 3 players
  bool get isValidToStart => _players.length >= 3;

  void addPlayer(String name) {
    if (name.trim().isEmpty) return;
    
    // Assign a random avatar (0-8)
    final avatarIndex = (DateTime.now().millisecondsSinceEpoch + _players.length) % 9;
    
    _players.add(Player(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      avatarPath: '${_selectedTheme.avatarAssetFolder}avatar_$avatarIndex.png',
    ));
    notifyListeners();
  }

  void selectTheme(String themeId) {
    _selectedTheme = ThemeRepository.getTheme(themeId);
    // Update existing players avatars to match new theme
    for (int i = 0; i < _players.length; i++) {
        final avatarIndex = (DateTime.now().millisecondsSinceEpoch + i) % 9;
        _players[i].avatarPath = '${_selectedTheme.avatarAssetFolder}avatar_$avatarIndex.png';
    }
    notifyListeners();
  }

  void removePlayer(String id) {
    _players.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void resetGame() {
    _players.clear();
    notifyListeners();
  }

  void clearRoles() {
    for (var p in _players) {
      p.isImposter = false;
      p.assignedQuestion = null;
    }
    notifyListeners();
  }

  void startGame() {
    if (_players.length < 3) return;

    // 1. Reset previous roles
    clearRoles();

    // 2. Select Imposter
    final random = Random();
    int imposterIndex = random.nextInt(_players.length);
    _players[imposterIndex].isImposter = true;

    // 3. Select Topic based on Theme
    final topic = TopicRepository.getRandomTopic(_selectedTheme.id);

    // 4. Assign Questions
    for (int i = 0; i < _players.length; i++) {
      if (i == imposterIndex) {
        _players[i].assignedQuestion = topic.imposter;
      } else {
        _players[i].assignedQuestion = topic.common;
      }
    }
    notifyListeners();
  }
}
