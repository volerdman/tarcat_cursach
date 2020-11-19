import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarcat_kursach/widgets/button_gradient.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

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
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
