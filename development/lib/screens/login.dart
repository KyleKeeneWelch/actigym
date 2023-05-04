// CIS099-2 Mobile Application Development.
// Assignment 2.
// ActiGym - Workout creator, tracker and logger.
// Kyle Keene - Welch, 2101940
// login.dart

import 'package:flutter/material.dart';
import 'home.dart';
import '../components/sqlhelper.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Stops keyboard popup from pushing page elements off screen.
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
                    hintText: 'Enter your username...',
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
                    hintText: 'Enter your password...',
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
                // When pressed, get accounts and check if entered details as a pair equal the details on an account. Go to home page and pass account Id is so.
                onPressed: () async {
                  try {
                    final account = await SQLHelper.getAccount(
                        usernameController.text, passwordController.text);

                    if (account[0]["username"] == usernameController.text &&
                        account[0]["password"] == passwordController.text) {
                      // Inform user.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Login Successful',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.black,
                      ));

                      String id = (account[0]["id"]).toString();
                      // Go to Home page and pass account Id.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    currentId: id,
                                  )));
                    }
                  } catch (e) {
                    // Inform user of error.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Login Unsuccessful',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Colors.black,
                    ));
                    usernameController.text = '';
                    passwordController.text = '';
                  }
                },
                child: Text('Log in',
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0),
                onPressed: () {
                  // When pressed, go to register page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                },
                child: Text('Register',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ],
        ));
  }
}
