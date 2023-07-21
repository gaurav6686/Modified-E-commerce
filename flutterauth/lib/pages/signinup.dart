import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config.dart';
import 'HomePage.dart';
import 'bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInUp extends StatefulWidget {
  const SignInUp({super.key});

  @override
  State<SignInUp> createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SharedPreferences prefs;
  bool isLogin = true;

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> signUp() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final apiUrl = 'http://192.168.131.223:3000/user/signup';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];
        print('token: $token');
      } else {
        final error = json.decode(response.body)['msg'];
        print('Error: $error');
      }
    } catch (e) {
      print('Exception occurred while signing up: $e');
    }
  }

  Future<void> signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final apiUrl = 'http://192.168.131.223:3000/user/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        prefs.setString('token', token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar(token: token)),
        );
        print(token);
      } else {
        final error = json.decode(response.body)['message'];
      if (error != null) {
        showAlertDialog(context, error); 
      } else {
        showAlertDialog(context, 'An error occurred while logging in.'); 
      }
    }
    } catch (e) {
      print('Exception occurred while logging in: $e');
    }

    return null;
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      height: 50.fh,
      child: ElevatedButton(
        onPressed: isLogin ? signIn : signUp,
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF6318AF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(isLogin ? 'Login' : 'Register'),
      ),
    );
  }

//  change the login to register (viceversa)
  Widget _LoginOrregisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: ClipPath(
                clipper: TopCurvesClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.92,
                  color: const Color(0xFF6318AF),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.fh),
                      child: Column(
                        children: [
                          Container(
                            width: 100.fw,
                            height: 100.fh,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assests/Logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.fh,
                          ),
                          Text(
                            'EatSure',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.06,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 280.fh,
              left: 20.fw,
              child: Text(
                'Login or Signup',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Colors.black45,
                ),
              ),
            ),
            Positioned(
              top: 330.fh,
              left: 20.fw,
              right: 20.fw,
              child: Column(
                children: [
                  if (!isLogin)
                    SizedBox(
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 66, 0),
                            ),
                          ),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                  // SizedBox(
                  //   child: TextField(
                  //     controller: _usernameController,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: const Color.fromARGB(255, 255, 66, 0),
                  //         ),
                  //       ),
                  //       labelText: 'Name',
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 66, 0),
                          ),
                        ),
                        labelText: 'Email Id',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 255, 66, 0),
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _submitButton(),
                  _LoginOrregisterButton(),
                  SizedBox(
                    height: 60.fh,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopCurvesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // First Curve
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.4,
        size.width * 0.3, size.height * 0.3);

    // Second Curve
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.4,
        size.width * 0.7, size.height * 0.3);

    // Third Curve
    path.quadraticBezierTo(
        size.width * 0.90, size.height * 0.4, size.width, size.height * 0.3);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
