import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/pages/HomePage.dart';
import 'package:flutterauth/pages/NewOrderPage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required token});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  //BottomNavigator Screens
  final List<Widget> _pages = [
    HomePage(
      token: null,
    ),
    WishlistScreen(),
    order(
        orderData: OrderData(
      photo: 'assests/third.png',
      name: 'Default Platter',
      price: '₹ 230',
      count: 0,
      address: '',
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home, 'Home', 0),
              buildNavItem(Icons.favorite, 'Wishlist', 1),
              buildNavItem(Icons.shopping_cart, 'Orders', 2),
              buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return Tooltip(
      message: label,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index ? Colors.purple : Colors.black,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index ? Colors.purple : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
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
        address: docSnapshot.get('address'),
      );
      orders.add(orderData);
    }
  } catch (e) {
    print('Error fetching orders from Firestore: $e');
  }
  return orders;
}

class order extends StatelessWidget {
  final orderData;
  order({required this.orderData});
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
                            NewOrderPage(orderData: snapshot.data![index]),
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

// wishlistScreen
class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WishlistScreen'),
      ),
      body: Center(
        child: Text('Profile Screen', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
