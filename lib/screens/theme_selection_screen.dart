import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../data/themes.dart';
import '../theme/app_theme.dart';
import 'setup_screen.dart';
import 'settings_screen.dart';
import 'premium_screen.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT MISSION'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // List view style cards
          childAspectRatio: 2.5,
          mainAxisSpacing: 16,
        ),
        itemCount: ThemeRepository.themes.length,
        itemBuilder: (context, index) {
          final gameProvider = context.watch<GameProvider>();
          final theme = ThemeRepository.themes[index];
          final bool isLocked = index > 0 && !gameProvider.isPremium;

          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () {
                if (isLocked) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PremiumScreen()),
                  );
                } else {
                  context.read<GameProvider>().selectTheme(theme.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SetupScreen()),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isLocked 
                        ? [Colors.grey.shade900, Colors.grey.shade800]
                        : [theme.primaryColor.withOpacity(0.8), theme.primaryColor.withOpacity(0.4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      color: Colors.black26,
                      child: Center(
                        child: Icon(
                          theme.icon,
                          size: 48,
                          color: isLocked ? Colors.white24 : theme.accentColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              theme.name.toUpperCase(),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              theme.description,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(
                        isLocked ? Icons.lock : Icons.arrow_forward_ios,
                        color: isLocked ? AppTheme.accentColor : Colors.white54,
                        size: isLocked ? 20 : 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
