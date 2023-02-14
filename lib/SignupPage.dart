import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 30, 30),
        body: Padding(
            padding: const EdgeInsets.all(60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Text(
                    'Create account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Enter your Name, Email and Password for sign up.',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          cursorColor: const Color.fromARGB(255, 4, 80, 2),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Phone number',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          cursorColor: const Color.fromARGB(255, 4, 80, 2),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          cursorColor: const Color.fromARGB(255, 4, 80, 2),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Confirm password',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          cursorColor: const Color.fromARGB(255, 4, 80, 2),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "By Signing up you agree to our Terms Conditions & Privacy Policy.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ))
              ],
            )));
  }
}
