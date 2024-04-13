import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<User> _users = [];
  User? _userToEdit; // Variable to keep track of the user being edited

  void _addOrUpdateUser() async {
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;

    if (_userToEdit == null) {
      // We're adding a new user
      User newUser = User(firstName: firstName, lastName: lastName);
      await _dbHelper.insertUser(newUser);
    } else {
      // We're updating an existing user
      User updatedUser = User(
        id: _userToEdit!.id,
        firstName: firstName,
        lastName: lastName,
      );
      await _dbHelper.updateUser(updatedUser);
      _userToEdit = null; // Reset the editing state
    }

    _firstNameController.clear();
    _lastNameController.clear();
    _refreshUserList();
  }

  void _editUser(User user) {
    // Set the user to be edited and populate the text fields
    setState(() {
      _userToEdit = user;
      _firstNameController.text = user.firstName;
      _lastNameController.text = user.lastName;
    });
  }

  void _deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    _refreshUserList();
  }

  void _refreshUserList() async {
    List<User>? users = await _dbHelper.queryAllUsers();
    setState(() {
      _users = users ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD SQLite'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last name'),
            ),
          ),
          ElevatedButton(
            onPressed: _addOrUpdateUser,
            child: Text(_userToEdit == null ? 'ADD' : 'UPDATE'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) {
                User user = _users[index];
                return ListTile(
                  title: Text("${user.firstName} ${user.lastName}"),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editUser(user), // Call _editUser with the current user
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteUser(user.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
