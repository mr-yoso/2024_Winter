import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Demo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Flutter'),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Close the drawer before navigating to the next screen
                Navigator.of(context).pop();
                // Navigate to the SettingsScreen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You are logging out from the app'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Main Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  Future<List<dynamic>> fetchJsonData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<List>(
        future: fetchJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var photo = snapshot.data![index];
                return ListTile(
                  leading: ClipOval(
                    child: Image.network(photo['thumbnailUrl'],
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(photo['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Album ID: ${photo['albumId']}'),
                      Text('ID: ${photo['id']}'),
                      // Additional subtitle for the id
                    ],
                  ),
                  trailing: Image.network(photo['thumbnailUrl'],
                      width: 100, height: 100, fit: BoxFit.cover),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings UI'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title:
                Text('Common', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('English'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.cloud_queue),
            title: Text('Environment'),
            subtitle: Text('Production'),
          ),
          ListTile(
            title:
                Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone number'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title:
                Text('Security', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            secondary: Icon(Icons.lock),
            title: Text('Lock app in background'),
            value: true,
            onChanged: (bool value) {
              // Handle switch change
            },
          ),
        ],
      ),
    );
  }
}
