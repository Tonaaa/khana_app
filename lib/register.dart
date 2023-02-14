import 'package:flutter/material.dart';

import 'SignUpPage.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Image.asset('assets/images/logo.PNG'),
            const Text('Welcome to Khaana App',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            SizedBox(
                height: 50,
                width: 200,
                // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()));
                  },
                )),
            const Text(
                'By Signing up, you agree to our Terms Conditions & Privacy Policy.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
