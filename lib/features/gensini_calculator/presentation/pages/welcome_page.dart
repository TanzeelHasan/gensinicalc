import 'package:flutter/material.dart';
import 'package:gensinicalc/routes/routes.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Gensini Score Calculator",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Assess the severity of coronary artery disease\nbased on lesion characteristics.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/centre_image.png',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
            Spacer(),

            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.calculator);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 56), // Full width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ), // Pill shape
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "Start Gensini Calculator",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
