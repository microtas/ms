import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _appointments = _getAppointments();
  }

  List<Appointment> _getAppointments() {
    return [
      Appointment(
        startTime: DateTime(2025, 2, 17, 9, 0),
        endTime: DateTime(2025, 2, 17, 10, 30),
        subject: 'Meeting with Bob',
        location: 'Room A',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime(2025, 2, 17, 14, 0),
        endTime: DateTime(2025, 2, 17, 15, 0),
        subject: 'Doctor Appointment',
        location: 'Clinic',
        color: Colors.green,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SfCalendar(
        backgroundColor: Colors.white,
        view: CalendarView.week,
        firstDayOfWeek: 1,
        todayHighlightColor: Colors.blue,
        headerStyle: const CalendarHeaderStyle(
          textStyle: TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.lightBlue,
        ),
        timeSlotViewSettings: const TimeSlotViewSettings(
          startHour: 1,
          endHour: 24,
          timeInterval: Duration(minutes: 90),
          timeIntervalWidth: 200,
          timeIntervalHeight: 50,
          timeTextStyle: TextStyle(fontSize: 14, color: Colors.black54),
          timeFormat: 'HH:mm',
        ),
        dataSource: MeetingDataSource(_appointments),
        appointmentTextStyle: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onTap: (details) {
          if (details.appointments != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    details.appointments![0].subject,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.lightBlue),
                          const SizedBox(width: 8),
                          Text(
                            'From ${formatTime(details.appointments![0].startTime)} to ${formatTime(details.appointments![0].endTime)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.lightBlue),
                          const SizedBox(width: 8),
                          Text('Location: ${details.appointments![0].location}'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
