import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';
import '../models/player.dart';
import 'result_screen.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({super.key});

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String? _selectedPlayerId;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('WHO IS THE PRETENDER?'),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: game.players.length,
                  itemBuilder: (context, index) {
                    final player = game.players[index];
                    final isSelected = _selectedPlayerId == player.id;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPlayerId = player.id;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected 
                            ? Border.all(color: AppTheme.accentColor, width: 2) 
                            : Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white24,
                              backgroundImage: player.avatarPath != null 
                                ? AssetImage(player.avatarPath!) 
                                : null,
                              child: player.avatarPath == null
                                ? Text(
                                    player.name[0].toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                player.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: AppTheme.accentColor),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedPlayerId != null
                        ? () {
                            // Find the selected player object
                            final selectedPlayer = game.players.firstWhere((p) => p.id == _selectedPlayerId);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(votedPlayer: selectedPlayer),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.errorColor,
                    ),
                    child: const Text('VOTE TO EJECT'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
