import 'package:flutter/material.dart';
import 'package:gensinicalc/routes/routes.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
        onPressed: () {
          context.push(AppRoutes.calculator);
        },
        label: Text("Start Gensini Calculator"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      ),
    );
  }
}