import 'package:flutter/material.dart';

class LesionCard extends StatefulWidget {
  final int index;

  const LesionCard({super.key, required this.index});

  @override
  State<LesionCard> createState() => _LesionCardState();
}

class _LesionCardState extends State<LesionCard> {
  late TextEditingController stenosisController;
  String? collaterals = "N/A";
  String? sourceVesselStenosis = "N/A";
  String? dominance = "Right";

  double severityScore = 0;
  double multiplicationFactor = 0;
  double lesionScore = 0;

  final Map<String, Map<String, double>> multiplicationFactors = {
    "RCA Proximal": {"Right": 1, "Left": 1},
    "RCA Mid": {"Right": 1, "Left": 1},
    "RCA Distal": {"Right": 1, "Left": 1},
    "PDA": {"Right": 1, "Left": 1},
    "PLB": {"Right": 0.5, "Left": 0.5},
    "Left Main": {"Right": 5, "Left": 5},
    "LAD Proximal": {"Right": 2.5, "Left": 2.5},
    "LAD Mid": {"Right": 1.5, "Left": 1.5},
    "LAD Apical": {"Right": 1, "Left": 1},
    "1st Diagonal": {"Right": 1, "Left": 1},
    "2nd Diagonal": {"Right": 0.5, "Left": 0.5},
    "LCx Proximal": {"Right": 2.5, "Left": 3.5},
    "LCx Mid": {
      "Right": 1,
      "Left": 2,
    }, // Matches LCx Mid values from spreadsheet
    "LCx Distal": {"Right": 1, "Left": 2},
    "Obtuse Marginal": {"Right": 1, "Left": 1},
  };

  // Dropdown options
  final List<String> collateralsOptions = ["Yes", "No", "N/A"];
  final List<String> sourceVesselOptions = [
    "N/A",
    "0%",
    "25%",
    "50%",
    "75%",
    "90%",
    "99%",
  ];
  final List<String> dominanceOptions = ["Right", "Left"];
  final List<String> coronarySegments = [
    "RCA Proximal",
    "RCA Mid",
    "RCA Distal",
    "PDA",
    "PLB",
    "Left Main",
    "LAD Proximal",
    "LAD Mid",
    "LAD Apical",
    "1st Diagonal",
    "2nd Diagonal",
    "LCx Proximal",
    "LCx Mid",
    "LCx Distal",
    "Obtuse Marginal",
  ];

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
    final collateralsValue = collaterals ?? "N/A";
    final sourceVesselValue = sourceVesselStenosis ?? "N/A";
    final dominanceValue = dominance ?? "Right";
    final segment = coronarySegments;

    if (stenosis < 99) {
      collaterals = "N/A";
      sourceVesselStenosis = "N/A";
    } else if (collaterals != "Yes") {
      sourceVesselStenosis = "N/A";
    }

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
    multiplicationFactor = multiplicationFactors[segment]?[dominanceValue] ?? 0;

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
              value: "RCA Proximal",
              items:
                  coronarySegments.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: value != "N/A",
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (_) {
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
