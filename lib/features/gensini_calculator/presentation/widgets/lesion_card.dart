import 'package:flutter/material.dart';

class LesionCard extends StatelessWidget {
  final int index;

  const LesionCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Lesion ${index + 1}",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),

            // Stenosis (%)
            TextFormField(
              decoration: const InputDecoration(labelText: "Stenosis (%)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Coronary Segment Dropdown
            const Text("Coronary Segment"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "RCA Proximal", child: Text("RCA Proximal")),
                DropdownMenuItem(value: "RCA Mid", child: Text("RCA Mid")),
                DropdownMenuItem(value: "RCA Distal", child: Text("RCA Distal")),
                DropdownMenuItem(value: "PDA", child: Text("PDA")),
                DropdownMenuItem(value: "PLB", child: Text("PLB")),
                DropdownMenuItem(value: "Left Main", child: Text("Left Main")),
                DropdownMenuItem(value: "LAD Proximal", child: Text("LAD Proximal")),
                DropdownMenuItem(value: "LAD Mid", child: Text("LAD Mid")),
                DropdownMenuItem(value: "LAD Apical", child: Text("LAD Apical")),
                DropdownMenuItem(value: "1st Diagonal", child: Text("1st Diagonal")),
                DropdownMenuItem(value: "2nd Diagonal", child: Text("2nd Diagonal")),
                DropdownMenuItem(value: "LCx Proximal", child: Text("LCx Proximal")),
                DropdownMenuItem(value: "LCx Mid", child: Text("LCx Mid")),
                DropdownMenuItem(value: "LCx Distal", child: Text("LCx Distal")),
                DropdownMenuItem(value: "Obtuse Marginal", child: Text("Obtuse Marginal")),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16),

            // Collaterals Dropdown
            const Text("Collaterals"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "Yes", child: Text("Yes")),
                DropdownMenuItem(value: "No", child: Text("No")),
                DropdownMenuItem(value: "N/A", child: Text("N/A")),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16),

            // Source Vessel Stenosis (%) Dropdown
            const Text("Source Vessel Stenosis (%)"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "N/A", child: Text("N/A")),
                DropdownMenuItem(value: "0%", child: Text("0%")),
                DropdownMenuItem(value: "25%", child: Text("25%")),
                DropdownMenuItem(value: "50%", child: Text("50%")),
                DropdownMenuItem(value: "75%", child: Text("75%")),
                DropdownMenuItem(value: "90%", child: Text("90%")),
                DropdownMenuItem(value: "99%", child: Text("99%")),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16),

            // Dominance Dropdown
            const Text("Dominance"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "Right", child: Text("Right")),
                DropdownMenuItem(value: "Left", child: Text("Left")),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}