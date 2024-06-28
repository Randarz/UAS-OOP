import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'order_page.dart'; // Use the correct path for the orders page
import 'itempage.dart'; // Use the correct path for the items page
import 'userpage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Declare and initialize _selectedIndex

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      DashboardPage(
        username: 'UserName',
        profileImageUrl: 'lib/img/smrek.jpg',
        onItemTapped: _onItemTapped, // Pass the callback function
      ),
      OrderPage(),
      ItemPage(),
      UserPage(
        username: 'UserName',
        profileImageUrl: 'lib/img/smrek.jpg',
        completedOrders: 4394,
        rating: 5.0,
        operationalHours: '24 Hours',
      ),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.8), // Set background color with transparency
          items: [
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: _selectedIndex == 0
                      ? Border.all(color: Color(0xFFD6E6ED), width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: Color(0xFFD6E6ED),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: _selectedIndex == 1
                      ? Border.all(color: Color(0xFFD6E6ED), width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: Color(0xFFD6E6ED),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: _selectedIndex == 2
                      ? Border.all(color: Color(0xFFD6E6ED), width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFFD6E6ED),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: _selectedIndex == 3
                      ? Border.all(color: Color(0xFFD6E6ED), width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Color(0xFFD6E6ED),
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFD6E6ED),
          unselectedItemColor: Color(0xFFD6E6ED),
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
