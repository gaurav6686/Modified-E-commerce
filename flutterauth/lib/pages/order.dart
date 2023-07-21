import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/pages/HomePage.dart';
import 'package:flutterauth/pages/seeorders.dart';
import 'bottomnavbar.dart';

class orderCheck extends StatelessWidget {
  final orderData;

  orderCheck({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Check'),
        backgroundColor: const Color(0xFF6318AF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                orderData.photo,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Platter Name: ${orderData.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Price: ${orderData.price}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Count: ${orderData.count}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Address: ${orderData.address}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeeOrder()),
                    );
                  },
                  child: const Text(
                    'Deliver',
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
            ),
          ],
        ),
      ),
    );
  }
}
