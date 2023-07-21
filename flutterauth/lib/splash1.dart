import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterauth/pages/selectSign.dart';
import 'package:flutterauth/pages/signinup.dart';
import 'package:flutterauth/pages/signupin.dart';


class Splash2 extends StatefulWidget {
  const Splash2({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectSign()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF6318AF),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 180,
                child: Image.asset('assests/Logo.png'),
              ),
              Text(
                'EatSure',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF7E5B7),
                ),
              ),
              Text(
                'Food Court on an App',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFF7E5B7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
