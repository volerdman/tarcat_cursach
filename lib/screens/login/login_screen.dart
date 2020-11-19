import 'package:flutter/material.dart';
import 'package:tarcat_kursach/screens/login/login_form.dart';
import 'package:tarcat_kursach/widgets/curved.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff9cbc9),
              Color(0xfff4ced9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(children: <Widget>[
            CurvedWidget(
              child: Container(
                padding: const EdgeInsets.only(top: 100, left: 50),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(1.0),
                  ],
                )),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 40, color: Color(0xff6a5543)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 230),
              child: LoginForm(),
            ),
          ]),
        ),
      ),
    );
  }
}
