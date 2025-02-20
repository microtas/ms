import 'package:flutter/material.dart';
import 'package:ms_maintain/Technicien/homepage_technicien.dart';
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
        color: Colors.blue[900]!,
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
      child: Scaffold(
     backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.blue[900],
                title: const Center(
                  child: Text(
                    "Plannig",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  HomePageTechnicien()));
                  },
                ),
              ),
        body: SfCalendar(
          
          backgroundColor: Colors.white,
          view: CalendarView.week,
          firstDayOfWeek: 1,
          todayHighlightColor: Colors.amber[600],
          headerStyle: CalendarHeaderStyle(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.blue[900],
          ),
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 1,
            endHour: 24,
            timeIntervalWidth: 250,
            timeIntervalHeight: 50,
            timeTextStyle: TextStyle(fontSize: 14, color: Colors.black54),
            timeFormat: 'HH:mm',
          ),
          dataSource: MeetingDataSource(_appointments),
          appointmentTextStyle: const TextStyle(
            fontSize: 9,
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
                      style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.amber[600]),
                            const SizedBox(width: 8),
                            Text(
                              'From ${formatTime(details.appointments![0].startTime)} to ${formatTime(details.appointments![0].endTime)}',
                              style: const TextStyle(color: Colors.black87, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                             Icon(Icons.location_on, color: Colors.amber[600]),
                            const SizedBox(width: 8),
                            Text(
                              'Location: ${details.appointments![0].location}',
                              style: const TextStyle(color: Colors.black87, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:  Text(
                          'Close',
                          style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
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
