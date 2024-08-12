import 'package:flutter/material.dart';

import '../screens/Property/Home_Property.dart';
import '../screens/Property/Sell_Property.dart';
import '../screens/chat/chat.dart';

class NavProperty extends StatefulWidget {
  @override
  _NavPropertyState createState() => _NavPropertyState();
}

class _NavPropertyState extends State<NavProperty> {
  int _selectedIndex = 0;
/*List<Widget> _widgetOptionsMain = <Widget>[
    HomeScreen(),
    SellVehicleScreen(),
    Text('Chat Screen'),
  ];

  List<Widget> _widgetOptionsVehicle = <Widget>[
    HomeScreen(),
    SellVehicleScreen(),
    Text('Chat Screen'),
  ];*/

  final List<Widget> _widgetOptionsProperty = <Widget>[
    const HomePropertyScreen(),
    const SellPropertyScreen(),
    const Chat(),
  ];

  @override
  initState() {
    super.initState();
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
        child: _widgetOptionsProperty.elementAt(_selectedIndex),
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
