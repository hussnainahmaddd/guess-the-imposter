import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../providers/game_provider.dart';
import '../theme/app_theme.dart';
import 'round_screen.dart';
import '../providers/sound_manager.dart';

class RevealScreen extends StatefulWidget {
  const RevealScreen({super.key});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> with SingleTickerProviderStateMixin {
  int _currentPlayerIndex = 0;
  bool _isRevealed = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 600),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!_isRevealed) {
      setState(() {
        _isRevealed = true;
      });
      _flipController.forward();
      SoundManager.playReveal();
    }
  }

  void _nextPlayer() {
    setState(() {
      _isRevealed = false;
      _currentPlayerIndex++;
    });
    _flipController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        if (_currentPlayerIndex >= game.players.length) {
          Future.microtask(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RoundScreen()),
          ));
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final currentPlayer = game.players[_currentPlayerIndex];

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        _isRevealed ? "TOP SECRET" : "PASSPORT CHECK",
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: _isRevealed ? AppTheme.errorColor : Colors.white54,
                        ),
                       ),
                       const SizedBox(height: 24),
                       
                       // Player Identity
                       CircleAvatar(
                         radius: 50,
                         backgroundColor: AppTheme.surfaceColor,
                         backgroundImage: currentPlayer.avatarPath != null 
                             ? AssetImage(currentPlayer.avatarPath!) 
                             : null,
                         child: currentPlayer.avatarPath == null
                             ? Text(currentPlayer.name[0].toUpperCase(), style: const TextStyle(fontSize: 40))
                             : null,
                       ),
                       const SizedBox(height: 16),
                       Text(
                         currentPlayer.name,
                         style: Theme.of(context).textTheme.displayMedium,
                       ),
                       const SizedBox(height: 48),

                       // THE CARD (Flip Animation)
                       GestureDetector(
                         onTap: _handleTap,
                         child: AnimatedBuilder(
                           animation: _flipAnimation,
                           builder: (context, child) {
                             // 3D Transform Logic
                             final angle = _flipAnimation.value * math.pi;
                             final transform = Matrix4.identity()
                               ..setEntry(3, 2, 0.001) // perspective
                               ..rotateY(angle);
                             
                             return Transform(
                               transform: transform,
                               alignment: Alignment.center,
                               child: angle < math.pi / 2
                                   ? _buildFrontCard()
                                   : Transform(
                                       transform: Matrix4.identity()..rotateY(math.pi),
                                       alignment: Alignment.center,
                                       child: _buildBackCard(currentPlayer.assignedQuestion),
                                     ),
                             );
                           },
                         ),
                       ),

                       const SizedBox(height: 48),

                       // Action Button
                       if (_isRevealed)
                         SizedBox(
                           width: double.infinity,
                           child: ElevatedButton(
                             onPressed: _nextPlayer,
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.white,
                               foregroundColor: Colors.black,
                               padding: const EdgeInsets.symmetric(vertical: 20),
                             ),
                             child: const Text("I'VE MEMORIZED IT"),
                           ),
                         )
                       else
                         Text(
                           "Ensure only ${currentPlayer.name} is looking!",
                           style: const TextStyle(color: Colors.white24),
                         ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFrontCard() {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fingerprint, size: 80, color: Colors.white24),
          const SizedBox(height: 24),
          Text(
            "TAP TO REVEAL\nMISSION",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(String? question) {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.white12,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Stamp effect
          Positioned(
             right: -20,
             top: 40,
             child: Transform.rotate(
               angle: -0.2,
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.red.withOpacity(0.3), width: 4),
                   borderRadius: BorderRadius.circular(8),
                 ),
                 child: Text(
                   "CLASSIFIED",
                   style: GoogleFonts.blackOpsOne(
                     fontSize: 32,
                     color: Colors.red.withOpacity(0.3),
                   ),
                 ),
               ),
             ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YOUR QUESTION",
                  style: GoogleFonts.outfit(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  question ?? "ERROR",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Memorize your answer!",
                    style: GoogleFonts.outfit(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
