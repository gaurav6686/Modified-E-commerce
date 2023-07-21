import 'package:flutter/material.dart';
import 'package:flutterauth/pages/signinup.dart';
import 'package:flutterauth/pages/signupin.dart';

class SelectSign extends StatefulWidget {
  const SelectSign({super.key});

  @override
  State<SelectSign> createState() => _SelectSignState();
}

class _SelectSignState extends State<SelectSign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 300),
        child: Center(
            child: Column(
          children: [
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInUp()),
                  );
                },
                child: const Text(
                  'User Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF6318AF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpIn()),
                  );
                },
                child: const Text(
                  'Admin Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF6318AF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
