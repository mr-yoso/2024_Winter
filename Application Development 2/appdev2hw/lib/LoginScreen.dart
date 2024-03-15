import 'package:flutter/material.dart';
import 'SecondScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _email = "bob@email.com";
  String _password = "1234";

  void _handleLogin() async {
    if (_emailController.text == _email &&
        _passwordController.text == _password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, '/Second');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Icon(
              Icons.wechat,
              size: 150.0,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.grey[200],
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
