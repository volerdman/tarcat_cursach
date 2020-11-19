import 'package:flutter/material.dart';
import 'package:tarcat_kursach/screens/register/register_screen.dart';
import 'package:tarcat_kursach/widgets/button_gradient.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidate: true,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password",
              ),
              obscureText: true,
              autovalidate: true,
            ),
            SizedBox(
              height: 10,
            ),
            ButtonGradient(
              width: 150,
              height: 50,
              onPressed: () {},
              text: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonGradient(
              width: 150,
              height: 50,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return RegisterScreen();
                    },
                  ),
                );
              },
              text: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
