// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// register.dart

import 'package:flutter/material.dart';
import '../components/sqlhelper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Avoids the page from going out of boundary when the keyboard popup appears.
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: 200,
                // Show ActiGym logo.
                child: Image.asset('assets/images/actigymlogo2.png')),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text('Username',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter new username...',
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    filled: true,
                    fillColor: Colors.white70,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text('Password',
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter new password...',
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    filled: true,
                    fillColor: Colors.white70,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                // When pressed, creates new account with the text input.
                onPressed: () async {
                  try {
                    await SQLHelper.createAccount(
                        usernameController.text, passwordController.text);

                    // Inform user.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Registration Successful',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black,
                    ));

                    Navigator.pop(context);
                  } catch (e) {
                    // Inform user of error.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Registration Unsuccessful',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Colors.black,
                    ));
                    usernameController.text = '';
                    passwordController.text = '';
                  }
                },
                child: Text('Register',
                    style: Theme.of(context).textTheme.bodyText1),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                // When pressed, pops the navigator stack to go back to the login page.
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    Text('Back', style: Theme.of(context).textTheme.bodyText1),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0),
              ),
            ),
          ],
        ));
  }
}
