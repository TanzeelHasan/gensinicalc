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
                    setState(() {
                      collaterals = value;
                      if (value != "Yes") {
                        sourceVesselStenosis = "N/A";
                      }
                    });
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
                    setState(() {
                      sourceVesselStenosis = value;
                    });
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
              onChanged: (_) {},
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
                setState(() {
                  dominance = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
