import 'package:flutter/material.dart';
import 'package:fyp5/screens/Vehicles/home_screen.dart';

import '../screens/Vehicles/Sell_Vehicle.dart';
import '../screens/chat/chat.dart';

class NavVehicle extends StatefulWidget {
  @override
  _NavVehicleState createState() => _NavVehicleState();
}

class _NavVehicleState extends State<NavVehicle> {
  int _selectedIndex = 0;
  /* List<Widget> _widgetOptionsMain = <Widget>[
    HomeScreen(),
    SellVehicleScreen(),
    Text('Chat Screen'),
  ];

  List<Widget> _widgetOptionsProperty = <Widget>[
    HomePropertyScreen(),
    SellPropertyScreen(),
    Text('Chat Screen'),
  ];*/

  final List<Widget> _widgetOptionsVehicle = <Widget>[
    const HomeScreen(),
    const SellVehicleScreen(),
    const Chat(),
  ];

  @override
  initState() {
    super.initState();

    /*  if (globals.navCheck == "property") {
      _widgetOptionsMain = List.from(_widgetOptionsProperty);
    } else {
      _widgetOptionsMain = List.from(_widgetOptionsVehicle);
    }*/
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      /* if (globals.navCheck == "property") {
        _widgetOptionsMain = List.from(_widgetOptionsProperty);
      } else {
        _widgetOptionsMain = List.from(_widgetOptionsVehicle);
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptionsVehicle.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
