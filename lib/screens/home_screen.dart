import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quapp/components/custom_elevated_button.dart';
import 'package:quapp/components/name_textfield.dart';
import 'package:quapp/screens/quiz_screen.dart';
import 'package:quapp/screens/score_list_screen.dart';
import 'package:quapp/utils/color.dart';
import '../models/quiz_view_model.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuizViewModel>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorGradientClass.mainGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              NameTextField(hintText: 'Adınız', controller: _nameController),
              DropdownButton<String>(
                value: viewModel.selectedCategory,
                onChanged: (String? newValue) {
                  viewModel.setSelectedCategory(newValue!);
                },
                items:
                    <String>['Bilim', 'Coğrafya'].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              CustomElevatedButton(
                text: 'Teste Başla',
                onPressed: () {
                  viewModel.setUserName(
                    _nameController.text.trim(),
                  );
                  viewModel.loadQuizQuestionsForSelectedCategory();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                },
              ),
              CustomElevatedButton(
                text: 'Geçmiş Puanlar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScoreListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
