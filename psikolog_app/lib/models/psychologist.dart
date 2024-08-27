class Psychologist {
  final String name;
  final String specialty;

  Psychologist({required this.name, required this.specialty});

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist(
      name: json['name'],
      specialty: json['specialty'],
    );
  }
}
