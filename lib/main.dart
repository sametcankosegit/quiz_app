import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quapp/screens/home_screen.dart';
import 'models/quiz_view_model.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        home: HomeScreen(),
      ),
    );
  }
}
