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
  final List<String> CoronarySegments = [
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

  bool get isStenosis100 => getStenosisValue() >= 100;

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
            Text(
              "Lesion ${widget.index + 1}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // Stenosis (%)
            TextFormField(
              controller: stenosisController,
              decoration: const InputDecoration(labelText: "Stenosis (%)"),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                setState(() {
                  // Auto-lock Collaterals when Stenosis changes
                  final stenosis = getStenosisValue();
                  if (stenosis < 99) {
                    collaterals = "N/A";
                    sourceVesselStenosis = "N/A";
                  }
                });
              },
            ),
            const SizedBox(height: 16),

            // Collaterals
            const Text("Collaterals"),
            const SizedBox(height: 8),
            IgnorePointer(
              ignoring: getStenosisValue() < 99,
              child: Opacity(
                opacity: getStenosisValue() >= 99 ? 1.0 : 0.5,
                child: DropdownButtonFormField<String>(
                  value: collaterals,
                  isExpanded: true,
                  items:
                      collateralsOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != "N/A",
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      collaterals = value;
                      if (value != "Yes") {
                        sourceVesselStenosis = "N/A";
                      }
                    });
                  },
                  decoration: const InputDecoration(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Source Vessel Stenosis (%)
            const Text("Source Vessel Stenosis (%)"),
            const SizedBox(height: 8),
            IgnorePointer(
              ignoring: collaterals != "Yes" || !isStenosis100,
              child: Opacity(
                opacity: collaterals == "Yes" && isStenosis100 ? 1.0 : 0.5,
                child: DropdownButtonFormField<String>(
                  value: sourceVesselStenosis,
                  isExpanded: true,
                  items:
                      sourceVesselOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          enabled: value != "N/A",
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      sourceVesselStenosis = value;
                    });
                  },
                  decoration: const InputDecoration(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Coronary Segment
            const Text("Coronary Segment"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: "RCA Proximal",
              items:
                  CoronarySegments.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      enabled: value != "N/A",
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (_) {},
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 16),

            // Dominance
            const Text("Dominance"),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: dominance,
              isExpanded: true,
              items:
                  dominanceOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  dominance = value;
                });
              },
              decoration: const InputDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}
