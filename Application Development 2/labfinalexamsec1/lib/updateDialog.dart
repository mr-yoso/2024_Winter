import 'package:flutter/material.dart';

class UpdateDialog extends StatefulWidget {
  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController _updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Task'),
      content: TextField(
        controller: _updateController,
        decoration: InputDecoration(hintText: 'Enter new task name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_updateController.text);
          },
          child: Text('UPDATE'),
        ),
      ],
    );
  }
}
