import 'package:animeworld/screens/anime_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.index});

  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentScreenIndex = 0;

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (widget.index != null) {
      _currentScreenIndex = widget.index;
    }
    super.initState();
  }

  final _destinations = [
    const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    const NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
    const NavigationDestination(icon: Icon(Icons.category), label: 'Categories'),
    const NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final _screens = const [
    AnimeScreen(),
    Center(child: Text('Search Screen')),
    Center(child: Text('Categories Screen')),
    Center(child: Text('Settings Screen')),
  ];

  bool canPop() {
    if (_currentScreenIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool onPopInvoked(bool didPop) {
    if (!didPop) {
      _currentScreenIndex = 0;
      setState(() {});
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: onPopInvoked,
      canPop: canPop(),
      child: Scaffold(
        body: _screens[_currentScreenIndex],
        bottomNavigationBar: NavigationBar(
          elevation: 12,
          destinations: _destinations,
          animationDuration: const Duration(milliseconds: 200),
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          selectedIndex: _currentScreenIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentScreenIndex = value;
            });
          },
        ),
      ),
    );
  }
}

