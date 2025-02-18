import 'package:flutter/material.dart';


class Task {
  String title;
  bool isAccepted;
  DateTime? startDate;
  DateTime? completedDate; // New field to store the completion date

  Task({required this.title, this.isAccepted = false, this.startDate, this.completedDate});
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [
    Task(title: "Réparer moteur"),
    Task(title: "Changer pneus"),
    Task(title: "Diagnostiquer freinage"),
  ];

  void acceptTask(int index) {
    setState(() {
      tasks[index].isAccepted = true;
      tasks[index].startDate = DateTime.now();
    });
  }

  void completeTask(int index) {
    setState(() {
      tasks[index].completedDate = DateTime.now(); 
      tasks[index].isAccepted = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tâches du Technicien", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(15.0),
                title: Text(
                  tasks[index].title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: tasks[index].isAccepted
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Début: ${tasks[index].startDate!.toLocal()}".split('.')[0],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      )
                    : tasks[index].completedDate != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Terminé: ${tasks[index].completedDate!.toLocal()}".split('.')[0],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          )
                        : null,
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: tasks[index].isAccepted
                        ? Colors.green
                        : tasks[index].completedDate != null
                            ? Colors.grey // Disable button if task is completed
                            : Colors.blue,
                  ),
                  onPressed: tasks[index].isAccepted
                      ? () => completeTask(index)
                      : (tasks[index].completedDate == null ? () => acceptTask(index) : null),
                  child: Text(
                    tasks[index].isAccepted
                        ? "Terminer"
                        : tasks[index].completedDate != null
                            ? "Terminé"
                            : "Accepter",
                    style: TextStyle(color: tasks[index].completedDate != null ? Colors.black : Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
