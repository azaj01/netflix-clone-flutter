import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_ui/screens/nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix UI',
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.black,),
      home: const NavScreen(),
    );
  }
}
