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