import 'package:delivery/page/AddBrand.dart';
import 'package:delivery/page/addBrantType.dart';
import 'package:delivery/page/addProduct.dart';
import 'package:delivery/page/buttomNavigation.dart';
import 'package:delivery/utility/saveSharePre.dart';
import 'package:delivery/widget/ListItemBrands.dart';
import 'package:delivery/widget/ListItemType.dart';
import 'package:delivery/widget/OnSelectListType.dart';
import 'package:flutter/material.dart';

class Dashbord extends StatefulWidget {
  @override
  _DashbordState createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  String login_user;
  void loadData() async {
    productType = ListType();
    product = ListMenu();
  }

  Widget productType;
  Widget product;

  @override
  void initState() {
    // TODO: implement initState]
    loadData();

    getValue('login_user').then((login_user) {
      print("my user type is :" + login_user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ປະເພດສິນຄ້າທັງໝົດ'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _title(title: 'ກູ່ມສິນຄ້າ'),
              _space(height: 20.0),
              productType,
              _space(height: 10.0),
              _title(title: 'ປະເພດສິນຄ້າ'),
              _space(height: 20.0),
              product,
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnSelectListType()));
          }),
    );
  }

  Widget _space({double height}) {
    return SizedBox(height: height);
  }

  Widget _title({String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 25, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
