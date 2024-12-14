import 'package:flutter/material.dart';
import 'package:mobileproject/features/home/ui/home_screen.dart';
import 'package:mobileproject/features/home/ui/sub_screen/account_screen.dart';
import 'package:mobileproject/features/home/ui/sub_screen/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];
  final List<BottomNavigationBarItem> _navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: "Cart",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: "Account",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: _navBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
