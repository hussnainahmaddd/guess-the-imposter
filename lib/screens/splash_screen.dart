import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import 'premium_screen.dart';
import 'theme_selection_screen.dart';
import '../theme/app_theme.dart';
import '../services/update_service.dart';
import '../providers/game_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _controller.forward();

    // Check for updates
    _checkAppVersion();
  }

  Future<void> _checkAppVersion() async {
    // Wait at least the duration of the animation (2s) so splash looks nice
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final updateData = await UpdateService.checkUpdate();

    if (!mounted) return;

    if (updateData != null) {
      // Show blocking dialog
      _showUpdateDialog(updateData['store_url']);
    } else {
      final prefs = await SharedPreferences.getInstance();
      final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
      
      if (!mounted) return;
      
      final gameProvider = context.read<GameProvider>();
      // Wait for initialization if needed
      while (!gameProvider.isInitialized) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (!mounted) return;

      if (!onboardingComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      } else {
        // Onboarding complete, go to game
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ThemeSelectionScreen()),
        );
        
        // If not premium, show the paywall on top
        if (!gameProvider.isPremium) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PremiumScreen()),
          );
        }
      }
    }
  }

  void _showUpdateDialog(String storeUrl) {
    showDialog(
      context: context,
      barrierDismissible: false, // User CANNOT close this
      builder: (context) => PopScope(
        canPop: false, // Android back button disabled
        child: AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text("Update Required", style: TextStyle(color: Colors.white)),
          content: Text(
            "A new version of the app is available. Please update to continue playing.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                 // Open Store URL
                 // launchUrl(Uri.parse(storeUrl), mode: LaunchMode.externalApplication);
              },
              child: const Text("UPDATE NOW"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Icon (if loaded) or Placeholder Icon
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                           BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/app_icon.png',
                          fit: BoxFit.cover, // Changed from contain to cover for full fill
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.rocket_launch, 
                            size: 80, 
                            color: AppTheme.primaryColor
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'THE PRETENDER',
                      style: GoogleFonts.outfit(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      'FIND THE PRETENDER',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: Colors.white70,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
