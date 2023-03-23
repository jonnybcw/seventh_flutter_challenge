import 'package:flutter/material.dart';
import 'package:seventh_flutter_challenge/config/repositories.dart';
import 'package:seventh_flutter_challenge/modules/core/core_screen.dart';

void main() {
  Repositories.register();
  runApp(const SeventhChallenge());
}

class SeventhChallenge extends StatelessWidget {
  const SeventhChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seventh Challenge',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const CoreScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
