import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psikolog_app/providers/appointment_provider.dart';
import '../models/appointment.dart';
import '../providers/user_role_provider.dart'; // UserRoleProvider import edilmelidir

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedType;
  bool _isPsikologAppointment = false;
  bool _isAsistanAppointment = false;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text =
            "${pickedTime.format(context)}"; // Format time to HH:mm AM/PM
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = "${pickedDate.toLocal()}"
            .split(' ')[0]; // Format date to YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRoleProvider = Provider.of<UserRoleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Randevu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Ad'),
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notlar'),
              maxLines: 3,
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tarih',
                hintText: 'Tarih seçin',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Saat',
                hintText: 'Saat seçin',
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () => _selectTime(context),
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(labelText: 'Randevu Türü'),
              items:
                  <String>['Muayene', 'Kontrol', 'Danışma'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue;
                  _isPsikologAppointment = newValue == 'Danışma';
                  _isAsistanAppointment = newValue == 'Kontrol';
                });
              },
            ),
            if (userRoleProvider.role == UserRole.psychologist ||
                userRoleProvider.role == UserRole.admin) ...[
              CheckboxListTile(
                title: Text('Psikolog Randevusu'),
                value: _isPsikologAppointment,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isPsikologAppointment = newValue ?? false;
                  });
                },
              ),
            ],
            if (userRoleProvider.role == UserRole.assistant ||
                userRoleProvider.role == UserRole.admin) ...[
              CheckboxListTile(
                title: Text('Asistan Randevusu'),
                value: _isAsistanAppointment,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isAsistanAppointment = newValue ?? false;
                  });
                },
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Ekle'),
              onPressed: () {
                final title = _titleController.text;
                final date = _selectedDate;
                final time = _selectedTime;
                final name = _nameController.text;
                final notes = _notesController.text;

                if (title.isNotEmpty &&
                    date != null &&
                    time != null &&
                    name.isNotEmpty &&
                    notes.isNotEmpty) {
                  final newAppointment = Appointment(
                    id: DateTime.now().toString(),
                    title: title,
                    date: DateTime(date.year, date.month, date.day, time.hour,
                        time.minute),
                    name: name,
                    notes: notes,
                    isPsikologAppointment: _isPsikologAppointment,
                    isAsistanAppointment: _isAsistanAppointment,
                  );
                  Provider.of<AppointmentProvider>(context, listen: false)
                      .addAppointment(newAppointment);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen tüm alanları doldurun')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
