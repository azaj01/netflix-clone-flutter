import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_ui/cubit/app_bar_cubit.dart';
import 'package:netflix_ui/screens/home_screen.dart';
import 'package:netflix_ui/screens/search_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = const [
    HomeScreen(key: PageStorageKey('homeScreen'),),
    SearchScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': FluentIcons.home_24_filled,
    'Search': FluentIcons.search_24_filled,
    'Coming Soon': Icons.queue_play_next_rounded,
    'Downloads': Icons.download_rounded,
    'More': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(create: (_) => AppBarCubit(),
          child: _screens[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(icon, size: 30.0),
                  label: title,
                )))
            .values
            .toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}
