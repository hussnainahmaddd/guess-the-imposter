import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';
import '../providers/sound_manager.dart';
import 'vote_screen.dart';
import 'discussion_screen.dart';

class RoundScreen extends StatefulWidget {
  const RoundScreen({super.key});

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> with TickerProviderStateMixin {
  int _currentPlayerIndex = 0;
  static const int _secondsPerTurn = 5;
  int _secondsRemaining = _secondsPerTurn;
  Timer? _timer;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
        vsync: this, duration: const Duration(seconds: _secondsPerTurn));
    _startTurn();
  }

  void _startTurn() {
    setState(() {
      _secondsRemaining = _secondsPerTurn;
    });
    _progressController.reverse(from: 1.0);
    
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        if (_secondsRemaining <= 3) {
            SoundManager.playTick();
        }
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _nextPlayer();
      }
    });
  }

  void _nextPlayer() {
    _timer?.cancel();
    final game = context.read<GameProvider>();
    if (_currentPlayerIndex < game.players.length - 1) {
      setState(() {
        _currentPlayerIndex++;
      });
      _startTurn();
    } else {
      // All done, go to voting
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DiscussionScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        final currentPlayer = game.players[_currentPlayerIndex];
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                   // Progress Bar
                   AnimatedBuilder(
                     animation: _progressController,
                     builder: (context, child) {
                       return LinearProgressIndicator(
                         value: _progressController.value,
                         backgroundColor: Colors.white10,
                         color: _progressController.value < 0.2 ? AppTheme.errorColor : AppTheme.accentColor,
                       );
                     },
                   ),
                   const SizedBox(height: 48),

                   Text(
                     "PLAYER ${_currentPlayerIndex + 1} OF ${game.players.length}",
                     style: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: 2),
                   ),
                   const Spacer(),
                   
                   CircleAvatar(
                     radius: 60,
                     backgroundColor: AppTheme.primaryColor,
                     backgroundImage: currentPlayer.avatarPath != null 
                        ? AssetImage(currentPlayer.avatarPath!) 
                        : null,
                     child: currentPlayer.avatarPath == null
                        ? Text(
                           currentPlayer.name[0].toUpperCase(),
                           style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                         )
                        : null,
                   ),
                   const SizedBox(height: 24),
                   Text(
                     "${currentPlayer.name}'s Turn",
                     style: Theme.of(context).textTheme.displaySmall,
                   ),
                   const SizedBox(height: 16),
                   Text(
                     "Answer the question!",
                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                   ),
                   
                   const Spacer(),
                   
                   Text(
                     "$_secondsRemaining",
                     style: Theme.of(context).textTheme.displayLarge?.copyWith(
                       fontSize: 80,
                       color: _secondsRemaining < 10 ? AppTheme.errorColor : Colors.white,
                     ),
                   ),
                   Text(
                     "SECONDS",
                     style: Theme.of(context).textTheme.bodySmall,
                   ),

                   const Spacer(),
                   
                   SizedBox(
                     width: double.infinity,
                     child: ElevatedButton(
                       onPressed: _nextPlayer, // Skip remaining time
                       child: const Text('DONE'),
                     ),
                   ),
                   const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
