import 'dart:convert';
import 'dart:io';

import 'package:delivery/page/LocationShop.dart';
import 'package:delivery/page/shopList.dart';
import 'package:delivery/provider/locationProvider.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final txtshopname = TextEditingController();
  final txtaddress = TextEditingController();
  final txtshoptype = TextEditingController();
  final txttel = TextEditingController();
  var token;

  Widget _locationShop = LocationShop();

  _clearData() {
    txttel.text = '';
    txtaddress.text = '';
    txtshoptype.text = '';
    txtshopname.text = '';
  }

  _addRegister() async {
    var lat;
    var lng;
    lat = Provider.of<LocationProvider>(context, listen: false).lat;
    lng = Provider.of<LocationProvider>(context, listen: false).lng;

    var _postData = {
      "SHOP_NAME": txtshopname.text,
      "SHOP_ADDRESS": txtaddress.text,
      "TEL_NO": txttel.text,
      "SHOP_TYPE": txtshoptype.text,
      "LOCATION": 'loaction',
      "STATUS": 'ACTIVE',
      "LASTS": lat,
      "LONGS": lng,
      "TOKEN": token
    };

    var dio = new Dio();
    try {
      setState(() {
        _loading();
      });
      Response response = await dio.post(
        ShareUrl.shopRegister,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(_postData),
      );
      var result = response.data;
      print('creat shop');
      print(result);

      if (response.statusCode != 200) {
        _dismiss();
        showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
      } else {
        if (result['status'] != 'success') {
          _dismiss();
          showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
        } else {
          _dismiss();
          showSuccessMessage(context, 'ບັນທຶກຂໍ້ມູນສຳເລັດ');
        }
      }
    } on DioError catch (e) {
      print(e);
      _dismiss();
      showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
    }
  }

  _loading() async {
    showLoading(context);
  }

  _dismiss() async {
    Dismiss(context);
  }

  getToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    String getToken = await firebaseMessaging.getToken();
    setState(() {
      token = getToken;
    });

    print("my token is " + token);
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລົງທະບຽນຮ້ານຄ້າ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _space(height: 50),
              _shopName(),
              _space(height: 15),
              _address(),
              _space(height: 15),
              _tel(),
              _space(height: 15),
              _shopType(),
              _space(height: 15),
              _location(),
              _space(height: 15),
              _save()
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.edit),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ShopList()));
          }),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _location() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 400,
        child: _locationShop,
      ),
    );
  }

  Widget _shopName() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtshopname,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຊື່ຮ້ານຄ້າ',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tel() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txttel,
          decoration: InputDecoration(
            labelText: 'ປ້ອนເບີໂທລະສັບ',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _address() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtaddress,
          decoration: InputDecoration(
            labelText: 'ປ້ອນສະຖານທີ່ຮ້ານ',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopType() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtshoptype,
          decoration: InputDecoration(
            labelText: 'ປ້ອນປະເພດຮ້ານ',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _save() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.blue)),
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            _addRegister();
          },
          child: Text(
            "ເພີ່ມຮ້ານຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
