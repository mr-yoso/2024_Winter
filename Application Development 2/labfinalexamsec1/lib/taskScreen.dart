import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:labfinalexamsec1/updateDialog.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('Tasks');

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      tasks.add({'name': _taskController.text, 'timestamp': Timestamp.now()});
      _taskController.clear();
    }
  }

  void _deleteTask(String id) {
    tasks.doc(id).delete();
  }

  void _updateTask(String id) async {
    String updatedName = await showDialog(
      context: context,
      builder: (context) => UpdateDialog(),
    );
    if (updatedName != null) {
      tasks.doc(id).update({'name': updatedName});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: tasks.orderBy('timestamp', descending: false).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var task = snapshot.data!.docs[index];
                    var timestamp = task['timestamp'] as Timestamp;
                    var formattedDate = DateFormat('yyyy-MM-dd hh:mm a')
                        .format(timestamp.toDate());
                    return ListTile(
                      title: Text(task['name']),
                      subtitle: Text(formattedDate),
                      // Display formatted timestamp
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(task.id),
                      ),
                      onTap: () => _updateTask(task.id),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Task name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('ADD'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
