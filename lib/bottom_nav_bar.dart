import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bio_flutter/providers/screen_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late ScreenProvider _screenProvider;
  late Screen _selectedScreen;
  bool navInitalized = false;

  @override
  void didChangeDependencies() {
    if (!navInitalized) {
      _screenProvider = Provider.of<ScreenProvider>(context);
      navInitalized = true;
    }

    _selectedScreen = _screenProvider.selectedScreen;
    super.didChangeDependencies();
  }

  void onItemTap(int index) {
    _screenProvider.selectedScreen = Screen.values[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biofit'),
      ),
      body: _screenProvider.displaySelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'Medições'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_chart), label: 'Nova Medição'),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedScreen.index,
        onTap: onItemTap,
      ),
    );
  }
}
