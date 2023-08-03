import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quapp/screens/home_screen.dart';
import '../utils/color.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: ColorGradientClass.mainGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.only(
                  left: 80.0,
                  right: 80.0,
                  top: 110,
                  bottom: 20,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
              // introduce text
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  'Bilgini ölçmeye hazır mısın?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSerif(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              const SizedBox(height: 24),

              const Spacer(),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorClass.customColor2,
                  ),
                  child: Text(
                    "BAŞLIYALIM",
                    style: GoogleFonts.notoSerif(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
