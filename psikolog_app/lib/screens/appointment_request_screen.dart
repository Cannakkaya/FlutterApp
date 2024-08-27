import 'package:flutter/material.dart';
import 'package:psikolog_app/models/psychologist.dart';
import 'package:intl/intl.dart';

class AppointmentRequestScreen extends StatefulWidget {
  final Psychologist psychologist;

  AppointmentRequestScreen({required this.psychologist});

  @override
  _AppointmentRequestScreenState createState() =>
      _AppointmentRequestScreenState();
}

class _AppointmentRequestScreenState extends State<AppointmentRequestScreen> {
  DateTime? _selectedDate;
  final _descriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.psychologist.name} ile Randevu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Randevu Talep Etmek İçin Bir Tarih Seçin"),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Tarih Seçili Değil'
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Tarih Seç'),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Randevu Açıklaması (isteğe bağlı)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Randevu talep işlemi
                if (_selectedDate != null) {
                  // DirectusService().requestAppointment(
                  //   psychologistId: widget.psychologist.id,
                  //   date: _selectedDate!,
                  //   description: _descriptionController.text,
                  // );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen bir tarih seçin.')),
                  );
                }
              },
              child: Text("Randevu Talep Et"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Psikolog ile iletişim için işlem
              },
              child: Text("İletişime Geç"),
            ),
          ],
        ),
      ),
    );
  }
}
