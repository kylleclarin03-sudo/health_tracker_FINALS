class HealthEntry {
  final DateTime date;
  final int steps;
  final double water; // in liters
  final double sleep; // in hours

  HealthEntry({
    required this.date,
    required this.steps,
    required this.water,
    required this.sleep,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'steps': steps,
      'water': water,
      'sleep': sleep,
    };
  }

  // Create from JSON
  factory HealthEntry.fromJson(Map<String, dynamic> json) {
    return HealthEntry(
      date: DateTime.parse(json['date']),
      steps: json['steps'],
      water: json['water'],
      sleep: json['sleep'],
    );
  }
}