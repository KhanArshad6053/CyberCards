import 'package:flutter/material.dart';
import '../widgets/glass_bottom_nav.dart';
import 'home_screen.dart';
import 'topics_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

/// Hosts the four bottom-navigation tabs: Home, Topics, Progress, Settings.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  void goToTab(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onNavigateToTab: goToTab),
      const TopicsScreen(),
      const ProgressScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: GlassBottomNav(
        currentIndex: _index,
        onTap: goToTab,
      ),
    );
  }
}
