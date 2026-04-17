import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';
import 'reveal_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _addPlayer() {
    if (_nameController.text.trim().isNotEmpty) {
      context.read<GameProvider>().addPlayer(_nameController.text);
      _nameController.clear();
      // Scroll to bottom to show new player
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASSEMBLE THE CREW'),
        leading: BackButton(
          onPressed: () {
             Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Player List
          Expanded(
            child: Consumer<GameProvider>(
              builder: (context, game, child) {
                if (game.players.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add_alt_1, size: 64, color: Colors.white24),
                        const SizedBox(height: 16),
                        Text(
                          'Add at least 3 players\nto start the game.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: game.players.length,
                  itemBuilder: (context, index) {
                    final player = game.players[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryColor.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: player.avatarPath != null
                              ? Transform.scale(
                                  scale: 1.6, // Zoom in to hide theme headers at the top
                                  alignment: const Alignment(0, 0.5), // Focus on the character (center-bottom)
                                  child: Image.asset(
                                    player.avatarPath!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    player.name[0].toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                        ),
                        title: Text(
                          player.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close, color: AppTheme.errorColor),
                          onPressed: () => game.removePlayer(player.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter name (e.g. Alice)',
                            filled: true,
                            fillColor: const Color(0xFF2C2C2C),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          onSubmitted: (_) => _addPlayer(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.add, color: Colors.black),
                        onPressed: _addPlayer,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<GameProvider>(
                    builder: (context, game, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: game.isValidToStart
                              ? () {
                                  game.startGame();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RevealScreen(),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: game.isValidToStart 
                              ? AppTheme.primaryColor 
                              : Colors.grey[800],
                            foregroundColor: game.isValidToStart 
                              ? Colors.white 
                              : Colors.white38,
                          ),
                          child: Text(
                            game.isValidToStart 
                              ? 'START GAME (${game.players.length})' 
                              : 'NEED ${3 - game.players.length} MORE',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
