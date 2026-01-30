import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/player.dart';
import '../theme/app_theme.dart';
import 'setup_screen.dart';
import '../providers/sound_manager.dart';

class ResultScreen extends StatefulWidget {
  final Player votedPlayer;

  const ResultScreen({super.key, required this.votedPlayer});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    SoundManager.playWin();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        // Find the real imposter
        final imposter = game.players.firstWhere((p) => p.isImposter);
        final commonTopic = game.players.firstWhere((p) => !p.isImposter).assignedQuestion;
        
        final crewWon = widget.votedPlayer.isImposter;
        
        return Scaffold(
          backgroundColor: crewWon ? AppTheme.accentColor.withOpacity(0.1) : AppTheme.errorColor.withOpacity(0.1),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(
                    crewWon ? Icons.celebration : Icons.warning_amber_rounded,
                    size: 80,
                    color: crewWon ? AppTheme.accentColor : AppTheme.errorColor,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    crewWon ? "CREW WINS!" : "PRETENDER WINS!",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: crewWon ? AppTheme.accentColor : AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    crewWon 
                      ? "You caught the Pretender!" 
                      : "You voted out ${widget.votedPlayer.name}, who was innocent...",
                     textAlign: TextAlign.center,
                     style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Reveal Layout
                  // Reveal Layout
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text("THE PRETENDER WAS", style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(height: 8),
                        Text(
                          imposter.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        // Add Illustration
                        const SizedBox(height: 16),
                        Container(
                           height: 120,
                           child: Image.asset(
                              crewWon ? 'assets/onboarding/vote.png' : 'assets/onboarding/secret.png',
                              fit: BoxFit.contain,
                           ),
                        ),
                        const Divider(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start, // Align to top for multi-line
                          children: [
                            Expanded( // Use Expanded to allow text wrap
                              child: Column(
                                children: [
                                  Text("Crew Topic", style: TextStyle(color: Colors.white54)),
                                  const SizedBox(height: 4),
                                  Text(
                                    commonTopic ?? "?", 
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded( // Use Expanded
                              child: Column(
                                children: [
                                  Text("Pretender Topic", style: TextStyle(color: Colors.white54)),
                                  const SizedBox(height: 4),
                                  Text(
                                    imposter.assignedQuestion ?? "?", 
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                      onPressed: () {
                         // Play Again with same players
                         game.startGame(); // Re-rolls roles and topics
                         // Pop back to setup? No, go directly to Reveal logic?
                         // Ideally we go back to Setup if they want to change players, 
                         // OR we just push RevealScreen again.
                         // Let's pop until we are at home, or maybe just go to Setup for flexibility.
                         // Actually, common pattern: "Play Again" -> Reveal (Quick restart).
                         // "New Game" -> Setup.
                         
                         // BUT, navigation stack management is tricky. 
                         // Safest: Go to SetupScreen (since it keeps state in Provider).
                         Navigator.popUntil(context, (route) => route.settings.name == '/'); 
                         // We don't have named routes setup.
                         // Let's navigate to SetupScreen (replacing current).
                         Navigator.pushReplacement(
                           context, 
                           MaterialPageRoute(builder: (context) => const SetupScreen()),
                         );
                      },
                      child: const Text('PLAY AGAIN'),
                    ),
                  ),
                  const SizedBox(height: 16),
                   SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                         game.resetGame();
                         Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('EXIT TO HOME'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
