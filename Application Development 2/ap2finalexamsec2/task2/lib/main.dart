import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore CRUD',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> names = [];

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addData() async {
    try {
      await firestore.collection('Users').doc(_idController.text).set({
        'name': _nameController.text,
      });
      _showDialog('Success', 'Person Added Successfully');
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  Future<void> _retrieveData() async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('Users').doc(_idController.text).get();
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (_nameController.text == data['name']) {
          setState(() {
            names.add(data['name']);
          });
          _showDialog('Success', 'Person Retrieved Successfully');
        } else {
          _showDialog('Error', 'Name does not match the database entry');
        }
      } else {
        _showDialog('Error', 'No Data Found');
      }
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  Future<void> _updateData() async {
    try {
      await firestore.collection('Users').doc(_idController.text).update({
        'name': _nameController.text,
      });
      _showDialog('Success', 'Person Updated Successfully');
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  Future<void> _deleteData() async {
    try {
      await firestore.collection('Users').doc(_idController.text).delete();
      setState(() {
        names.remove(_nameController.text);
      });
      _showDialog('Success', 'Person Deleted Successfully');
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'Enter ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter Name'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _addData,
                      child: Text('ADD'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _retrieveData,
                      child: Text('RETRIEVE'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _updateData,
                      child: Text('UPDATE'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _deleteData,
                      child: Text('DELETE'),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(names[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          names.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
