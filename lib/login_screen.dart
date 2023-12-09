import 'package:flutter/material.dart';
import 'package:events/shared/authentication.dart';
import 'launch_screen.dart';
import 'package:events/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  String? _userId;
  String? _password;
  String? _email;
  String? _message;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  Authentication? auth;

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Screen',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            emailInput(),
            SizedBox(height: 20),
            passwordInput(),
            SizedBox(height: 20),
            mainButton(),
            SizedBox(height: 10),
            secondaryButton(),
            SizedBox(height: 10),
            validationMessage(),
          ],
        ),
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(Icons.mail),
        ),
        validator: (text) => text!.isEmpty ? 'Email is required' : null,
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(Icons.enhanced_encryption),
        ),
        validator: (text) => text!.isEmpty ? 'Password is required' : null,
      ),
    );
  }

  Widget mainButton() {
    String buttonText = _isLogin ? 'Login' : 'Sign up';
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary:
              colorScheme.secondary, // Use the secondary color from colorScheme
          elevation: 3,
        ),
        child: Text(buttonText),
        onPressed: submit,
      ),
    );
  }

  Widget secondaryButton() {
    String buttonText = !_isLogin ? 'Login' : 'Sign up';
    return TextButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
          _message = null;
        });
      },
    );
  }

  Widget validationMessage() {
    return Text(
      _message ?? '',
      style: TextStyle(
        fontSize: 14,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> submit() async {
    setState(() {
      _message = "";
    });

    try {
      if (_isLogin) {
        _userId = await auth!.login(txtEmail.text, txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await auth!.signUp(txtEmail.text, txtPassword.text);
        print('Sign up for user $_userId');
      }

      if (_userId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventInformation()),
        );
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _message = e.toString();
      });
    }
  }
}
