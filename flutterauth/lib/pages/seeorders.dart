import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/pages/HomePage.dart';
import 'package:flutterauth/pages/NewOrderPage.dart';
import 'order.dart';

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

Future<List<OrderData>> fetchOrders() async {
  List<OrderData> orders = [];
  try {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await collectionRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      OrderData orderData = OrderData(
          photo: docSnapshot.get('photo'),
          name: docSnapshot.get('name'),
          price: docSnapshot.get('price'),
          count: docSnapshot.get('count'),
          address: docSnapshot.get('address'));
      orders.add(orderData);
    }
  } catch (e) {
    print('Error fetching orders from Firestore: $e');
  }
  return orders;
}

class SeeOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: const Color(0xFF6318AF),
      ),
      body: FutureBuilder<List<OrderData>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No orders found.'));
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      snapshot.data![index].photo,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    snapshot.data![index].name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Price: ${snapshot.data![index].price}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Count: ${snapshot.data![index].count}',
                        style: TextStyle(fontSize: 16),
                      ),
                      
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            orderCheck(orderData: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
