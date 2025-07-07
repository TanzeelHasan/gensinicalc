import 'package:flutter/material.dart';
import 'package:gensinicalc/features/gensini_calculator/presentation/widgets/lesion_card.dart';

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
        backgroundColor: Colors.grey,
        title: Text('Gensini Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 80.0),
        child: ListView.builder(
          itemCount: lesions.length + 1,
          itemBuilder: (context, index) {
            if (index < lesions.length) {
              // Regular lesion card
              return LesionCard(index: lesions[index]);
            } else {
              // Add button at the end
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {},
        label: Text("Calculate Score"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
