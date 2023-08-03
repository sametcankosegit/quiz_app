import 'package:flutter/material.dart';
import 'package:quapp/components/custom_text.dart';
import '../quiz_database/quiz_database.dart';
import '../utils/color.dart';

class ScoreListScreen extends StatefulWidget {
  const ScoreListScreen({super.key});

  @override
  _ScoreListScreenState createState() => _ScoreListScreenState();
}

class _ScoreListScreenState extends State<ScoreListScreen> {
  void _deleteAllScores() async {
    await QuizDatabase.instance.deleteAllScores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Puan Sıralaması'),
        backgroundColor: ColorClass.customColor2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorGradientClass.mainGradient,
        ),
        child: FutureBuilder(
          future: QuizDatabase.instance.queryAllRows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> scores =
                  List.from(snapshot.data as List<Map<String, dynamic>>);

              scores.sort(
                (a, b) => b['score'].compareTo(
                  a['score'],
                ),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        final score = scores[index];
                        return ListTile(
                          title: Text(
                            'AD: ${score['userId']} - PUAN: ${score['score']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Tarih: ${score['timestamp']}'),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _deleteAllScores(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorClass.buttonColor,
                    ),
                    child: const Text('Tüm geçmiş puanları sil'),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Geçmiş puan bulunamadı'),
              );
            }
          },
        ),
      ),
    );
  }
}
