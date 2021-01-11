import 'package:delivery/model/Distribu.dart';
import 'package:delivery/page/AddBrand.dart';
import 'package:delivery/page/CreateDist.dart';
import 'package:delivery/page/ListDist.dart';
import 'package:delivery/page/addBrantType.dart';
import 'package:delivery/page/dashBord.dart';
import 'package:delivery/widget/ListItemTypeforAdd.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatefulWidget {
  @override
  _ButtomNavigationState createState() => _ButtomNavigationState();
}

class _ButtomNavigationState extends State<ButtomNavigation> {
  int _currentIndex = 0;
  List<Widget> _child = [
    Dashbord(),
    AddBrandType(),
    ListItemTypeforAdd(),
    //CreatDis(),
    ListDist()
  ];

  void _onTapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onTapBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('ໜ້າຫຼັກ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('ເພີ່ມປະເພດສີນຄ້າ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              title: Text('ເພີ່ມສີນຄ້າ'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text('ຮ້ານສົ່ງເຄື່ອງ'),
            ),
          ]),
    );
  }
}
