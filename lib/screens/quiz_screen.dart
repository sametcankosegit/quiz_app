import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quapp/components/custom_elevated_button.dart';
import 'package:quapp/components/custom_text.dart';
import '../models/quiz_view_model.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuizViewModel>(context);
    precacheImage(const AssetImage('assets/images/confetti.jpg'), context);

    if (viewModel.currentQuestionIndex >= viewModel.quizQuestions.length) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/confetti.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(text: 'Test Tamamlandı'),
                  CustomText(text: 'Puanınız: ${viewModel.userScore}'),
                  CustomText(text: 'Adınız: ${viewModel.userName}'),
                  CustomElevatedButton(
                    onPressed: () {
                      viewModel.resetQuiz();
                      Navigator.pop(context);
                    },
                    text: 'Bitir',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final currentQuestion =
        viewModel.quizQuestions[viewModel.currentQuestionIndex];
    return Builder(
      builder: (context) {
        final viewModel = Provider.of<QuizViewModel>(context);
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(viewModel.backgroundImage),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: CustomText(text: currentQuestion.question),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...currentQuestion.options.map(
                    (option) => CustomElevatedButton(
                      onPressed: () {
                        viewModel.checkAnswer(
                          currentQuestion.options.indexOf(option),
                        );
                        if (viewModel.currentQuestionIndex >=
                            viewModel.quizQuestions.length) {
                          viewModel.storeUserScore(viewModel.userName);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizScreen(),
                            ),
                          );
                        }
                      },
                      text: option,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
