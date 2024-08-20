class Appointment {
  final String id;
  final String title;
  final DateTime date;
  final String name;
  final String notes;
  final bool isPsikologAppointment;
  final bool isAsistanAppointment;

  Appointment({
    required this.id,
    required this.title,
    required this.date,
    required this.name,
    required this.notes,
    this.isPsikologAppointment = false,
    this.isAsistanAppointment = false,
  });
}
