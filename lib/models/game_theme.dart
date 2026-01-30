import 'package:flutter/material.dart';

class GameTheme {
  final String id;
  final String name;
  final String description;
  final String avatarAssetFolder; // e.g. "assets/avatars/space/"
  final Color primaryColor;
  final Color accentColor;
  final IconData icon;

  const GameTheme({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarAssetFolder,
    required this.primaryColor,
    required this.accentColor,
    required this.icon,
  });
}
