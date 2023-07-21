import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/pages/HomePage.dart';
import 'bottomnavbar.dart';

class OrderData {
  final String photo;
  final String name;
  final String price;
  final int count;
  final String address;

  OrderData({
    required this.photo,
    required this.name,
    required this.price,
    required this.count,
    required this.address,
  });
}

class NewOrderPage extends StatefulWidget {
  final orderData;
  const NewOrderPage({Key? key, required this.orderData}) : super(key: key);

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  int digitValue = 0;
  int countValue = 0;
  String address = '';

  void increaseDigit() {
    setState(() {
      digitValue++;
      countValue++;
    });
  }

  void decreaseDigit() {
    setState(() {
      if (digitValue > 0) {
        digitValue--;
        countValue--;
      }
    });
  }

  void onAddressChanged(String newAddress) {
    setState(() {
      address = newAddress;
    });
  }

  Future<void> saveOrderToFirestore(OrderData orderData) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('orders');
      await collectionRef.add({
        'name': orderData.name,
        'price': orderData.price,
        'photo': orderData.photo,
        'count': orderData.count,
        'address': orderData.address,
      });
    } catch (e) {
      print('Error saving order to Firestore: $e');
    }
  }

  void navigateToOrderPage() {
    final orderData = OrderData(
        photo: 'assests/third.png',
        name: 'Default Platter',
        price: '₹ 230',
        count: countValue,
        address: address);

    // Save order data to Firestore
    saveOrderToFirestore(orderData);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => order(orderData: orderData)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6318AF),
        title: const Text('Order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Default Platter',
                      style: TextStyle(
                        color: Color(0xFF6318AF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      '₹ 230',
                      style: TextStyle(
                        color: Color(0xFF6318AF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assests/third.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add Item',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6318AF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: decreaseDigit,
                        icon: const Icon(Icons.remove),
                        color: Colors.white,
                        iconSize: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      digitValue.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6318AF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: increaseDigit,
                        icon: const Icon(Icons.add),
                        color: Colors.white,
                        iconSize: 25,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    onChanged: onAddressChanged,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: navigateToOrderPage,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    child: Text(
                      'Order',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF6318AF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
