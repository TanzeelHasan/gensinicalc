import 'package:flutter/material.dart';
import 'package:gensinicalc/features/gensini_calculator/presentation/widgets/lesion_card.dart';
import 'package:gensinicalc/routes/routes.dart';
import 'package:go_router/go_router.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int lesionCount = 0;
  List<int> lesions = [];

  void addLesion() {
    setState(() {
      lesions.add(lesionCount++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Gensini Calculator',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 120.0),
        child: ListView.builder(
          itemCount: lesions.length + 1,
          itemBuilder: (context, index) {
            if (index < lesions.length) {
              // Regular lesion card
              return LesionCard(index: lesions[index]);
            } else {
              // Add button at the end
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: ElevatedButton.icon(
                  onPressed: addLesion,
                  icon: Icon(Icons.add),
                  label: Text("Add Lesion"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            context.pushReplacement(AppRoutes.resultPage);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 56), // Full width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ), // Pill shape
            backgroundColor: Colors.black,
          ),
          child: const Text(
            "Calculate Score",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
