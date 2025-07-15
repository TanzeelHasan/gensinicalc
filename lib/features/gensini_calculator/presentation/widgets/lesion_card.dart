import 'package:flutter/material.dart';
import 'package:gensinicalc/core/constants/app_constant.dart';

class LesionCard extends StatefulWidget {
  final int index;

  const LesionCard({super.key, required this.index});

  @override
  State<LesionCard> createState() => _LesionCardState();
}

class _LesionCardState extends State<LesionCard> {
  late TextEditingController stenosisController;
  String collaterals = "N/A";
  String sourceVesselStenosis = "N/A";
  String dominance = "Right";
  String coronarySegment = "RCA Proximal";

  double severityScore = 0;
  double multiplicationFactor = 0;
  double lesionScore = 0;

  @override
  void initState() {
    super.initState();
    stenosisController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    stenosisController.dispose();
    super.dispose();
  }

  int getStenosisValue() {
    final text = stenosisController.text;
    if (text.isEmpty) return 0;
    try {
      return int.parse(text);
    } catch (e) {
      return 0;
    }
  }

  void _calculateScores() {
    final stenosis = getStenosisValue();
     if (stenosis < 99) {
      collaterals = "N/A";
      sourceVesselStenosis = "N/A";
    } else if (collaterals != "Yes") {
      sourceVesselStenosis = "N/A";
    }

    final collateralsValue = collaterals;
    final sourceVesselValue = sourceVesselStenosis;
    final dominanceValue = dominance;
    final coronarySegmentValue = coronarySegment;

   
    // Severity Score Calculation
    severityScore = 0;
    if (stenosis >= 1 && stenosis <= 25) {
      severityScore = 1;
    } else if (stenosis > 25 && stenosis <= 50) {
      severityScore = 2;
    } else if (stenosis > 50 && stenosis <= 75) {
      severityScore = 4;
    } else if (stenosis > 75 && stenosis <= 90) {
      severityScore = 8;
    } else if (stenosis > 90 && stenosis < 99) {
      severityScore = 16;
    } else if (stenosis == 99 && collateralsValue == "No") {
      severityScore = 16;
    } else if (stenosis == 99 && collateralsValue == "Yes") {
      severityScore = 8;
    } else if (stenosis == 100 && collateralsValue == "No") {
      severityScore = 32;
    } else if (stenosis == 100 && collateralsValue == "Yes") {
      switch (sourceVesselValue) {
        case "0%":
          severityScore = 16;
          break;
        case "25%":
          severityScore = 20;
          break;
        case "50%":
          severityScore = 24;
          break;
        case "75%":
          severityScore = 28;
          break;
        case "90%":
          severityScore = 30;
          break;
        case "99%":
          severityScore = 31;
          break;
        default:
          severityScore = 0;
      }
    }

    // Multiplication Factor
    multiplicationFactor =
        multiplicationFactors[coronarySegmentValue]?[dominanceValue] ?? 0;

    // Lesion Score
    lesionScore = severityScore * multiplicationFactor;

    setState(() {});
  }

  bool get isStenosis100 => getStenosisValue() >= 100;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lesion ${widget.index + 1}",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Stenosis (%)
            TextFormField(
              controller: stenosisController,
              decoration: const InputDecoration(
                labelText: "Stenosis (%)",
                hintText: "Enter stenosis percentage",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                _calculateScores();
              },
            ),
            const SizedBox(height: 16),

            // Collaterals
            Text(
              "Collaterals",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            IgnorePointer(
              ignoring: getStenosisValue() < 99,
              child: Opacity(
                opacity: getStenosisValue() >= 99 ? 1.0 : 0.5,
                child: DropdownButtonFormField<String>(
                  value: collaterals,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items:
                      collateralsOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != "N/A",
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    collaterals = value ?? "N/A";
                    _calculateScores();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Source Vessel Stenosis (%)
            Text(
              "Source Vessel Stenosis (%)",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            IgnorePointer(
              ignoring: collaterals != "Yes" || !isStenosis100,
              child: Opacity(
                opacity: collaterals == "Yes" && isStenosis100 ? 1.0 : 0.5,
                child: DropdownButtonFormField<String>(
                  value: sourceVesselStenosis,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items:
                      sourceVesselOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != "N/A",
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    sourceVesselStenosis = value ?? "N/A";
                    _calculateScores();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Coronary Segment
            Text(
              "Coronary Segment",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              value: coronarySegment,
              items:
                  coronarySegments.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: value != "N/A",
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                coronarySegment = value ?? "RCA Proximal";
                _calculateScores();
              },
            ),
            const SizedBox(height: 16),

            // Dominance
            Text(
              "Dominance",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: dominance,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items:
                  dominanceOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                dominance = value ?? "Right";
                _calculateScores();
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Severity Score: $severityScore",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Multiplication Factor: $multiplicationFactor",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Lesion Score: $lesionScore",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
