import 'package:flutter/material.dart';
import 'package:quapp/models/quiz_model.dart';
import '../quiz_database/quiz_database.dart';

class QuizViewModel with ChangeNotifier {
  String _userName = '';
  String get userName => _userName;

  String _backgroundImage = 'assets/images/science.jpg'; // Default bg image
  String get backgroundImage => _backgroundImage;

  String _scorebackground = 'assets/images/confetti.jpg'; // Default bg image
  String get scorebackground => _scorebackground;

  void setBackgroundImageForCategory(String category) {
    // Update bg image
    if (category == 'Bilim') {
      _backgroundImage = 'assets/images/science.jpg';
    } else {
      _backgroundImage = 'assets/images/geography.jpg';
    }
    notifyListeners();
  }

  void getBackgroundImage(int userScore) {
    if (userScore > 25) {
      _scorebackground = 'assets/images/confetti.jpg';
    } else {
      _scorebackground = 'assets/images/confetti.jpg';
    }
  }

  void setUserName(String name) {
    _userName = name;
  }

  final List<Quiz> _initialQuizQuestions = [
    Quiz(
      category: "Coğrafya",
      question: 'Van gölü hangi ilimizdedir?',
      options: ['Adana', 'Bursa', 'Edirne', 'Van'],
      correctOption: 3,
      points: 5,
    ),
    Quiz(
      category: 'Coğrafya',
      question: 'Selçuk Üniversitesi hangi ilimizdedir?',
      options: ['Konya', 'Muğla', 'Ağrı', 'İstanbul'],
      correctOption: 0,
      points: 10,
    ),
    Quiz(
      category: 'Coğrafya',
      question: 'KKTCnin başkenti neresidir?',
      options: ['Girne', 'Gazimağusa', 'Lefke', 'Lefoşa'],
      correctOption: 3,
      points: 5,
    ),
    Quiz(
      category: 'Coğrafya',
      question: 'Tuz Gölünün hangi illerimizde kıyısı yoktur?',
      options: ['Niğde', 'Ankara', 'Konya', 'Aksaray'],
      correctOption: 0,
      points: 10,
    ),
    Quiz(
      category: 'Coğrafya',
      question: 'Hangi iki ilimiz komşudur?',
      options: [
        'Kırıkkale - Nevşehir',
        'Çorum - Ankara',
        'Rize - Erzurum',
        'İstanbul - Yalova;'
      ],
      correctOption: 0,
      points: 10,
    ),
    Quiz(
      category: "Coğrafya",
      question: 'Hangi ilimizin sadece 1 komşusu vardır?',
      options: ['Iğdır', 'Kilis', 'Hakkari', 'Bartın'],
      correctOption: 1,
      points: 10,
    ),
    Quiz(
      category: "Coğrafya",
      question: 'Türkiyenin en kalabalık 4. şehri hangisidir?',
      options: ['Adana', 'Antalya', 'Bursa', 'Konya'],
      correctOption: 2,
      points: 15,
    ),
    Quiz(
      category: 'Bilim',
      question: 'Aya ilk hangi yılda ayak basılmıştır?',
      options: ['1978', '1973', '1969', '1965'],
      correctOption: 2,
      points: 15,
    ),
    Quiz(
      category: 'Bilim',
      question: 'Aşağıdakilerden hangisi bir gezegen adı değildir?',
      options: ['Satürn', 'Venüs', 'Kaptün', 'Neptün'],
      correctOption: 2,
      points: 5,
    ),
    Quiz(
      category: 'Bilim',
      question: 'DNA nın açılımı nedir?',
      options: [
        'Deoksiribonükleik asit',
        'Danbininükler asit',
        'Donuknakış asit',
        'Demirnamlu asit'
      ],
      correctOption: 0,
      points: 15,
    ),
    Quiz(
      category: 'Bilim',
      question: 'En nadir kan grubu nedir?',
      options: ['A', 'B', 'AB', '0'],
      correctOption: 2,
      points: 10,
    ),
    Quiz(
      category: 'Bilim',
      question: 'Köpekbalıklarının vücutlarında kaç kemik vardır?',
      options: ['400', '250', '98', '0'],
      correctOption: 3,
      points: 15,
    ),
  ];

  List<Quiz> _quizQuestions = [];
  List<Quiz> get quizQuestions => _quizQuestions;

  int _currentQuestionIndex = 0;
  int get currentQuestionIndex => _currentQuestionIndex;

  int _userScore = 0;
  int get userScore => _userScore;

  String _selectedCategory = 'Bilim';
  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Secilen kategoriye gore soru yukleme
  void loadQuizQuestionsForSelectedCategory() {
    _quizQuestions = _initialQuizQuestions
        .where((question) => question.category == _selectedCategory)
        .toList();
    setBackgroundImageForCategory(_selectedCategory);

    _currentQuestionIndex = 0;
    _userScore = 0;
  }

  void checkAnswer(int selectedOption) {
    final currentQuestion = _quizQuestions[_currentQuestionIndex];
    if (selectedOption == currentQuestion.correctOption) {
      _userScore += currentQuestion.points;
      getBackgroundImage(userScore);
    }
    _currentQuestionIndex++;
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userScore = 0;
    notifyListeners();
  }

  Future<void> deleteAllScores() async {
    await QuizDatabase.instance.deleteAllScores();
  }

  // Database for scores
  Future<void> storeUserScore(String userId) async {
    final timestamp = DateTime.now().toUtc().toString();

    final newScore = {
      'userId': userId,
      'score': _userScore,
      'timestamp': timestamp,
    };

    await QuizDatabase.instance.insertScore(newScore);
  }
}
