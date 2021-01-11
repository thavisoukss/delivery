import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Shop.dart';
import 'package:delivery/page/LocationShop.dart';
import 'package:delivery/provider/locationProvider.dart';
import 'package:delivery/provider/shopProvider.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EditShop extends StatefulWidget {
  @override
  _EditShopState createState() => _EditShopState();
}

class _EditShopState extends State<EditShop> {
  Data data;

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

  _getShop() async {
    setState(() {
      data = Provider.of<ShopProvider>(context, listen: false).data;
    });
    txtaddress.text = data.sHOPADDRESS;
    txtshopname.text = data.sHOPNAME;
    txtshoptype.text = data.sHOPTYPE;
    txttel.text = data.tELNO;
  }

  _updateShop() async {
    var lat;
    var lng;
    lat = Provider.of<LocationProvider>(context, listen: false).lat;
    lng = Provider.of<LocationProvider>(context, listen: false).lng;

    var _postData = {
      "ID": data.iD,
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
        ShareUrl.updateShop,
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
        _clearData();
        showErrorMessage(context, 'ແກ້ໄຂຂໍ້ມູນບໍ່ສຳເລັດ');
      } else {
        if (result['status'] == 'success') {
          _dismiss();
          _clearData();

          showSuccessMessage(context, 'ແກ້ໄຂຂໍ້ມູນສຳເລັດ');
        } else {
          _dismiss();
          _clearData();
          showErrorMessage(context, 'ແກ້ໄຂຂໍ້ມູນ່ສຳເລັດ');
        }
      }
    } on DioError catch (e) {
      print(e);
      _dismiss();
      showErrorMessage(context, 'ແກ້ໄຂຂໍ້ມູນບໍ່ສຳເລັດ');
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
    _getShop();
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ແກ້ໄຂຮ້ານຄ້າ'),
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
              side: BorderSide(color: Colors.orange)),
          color: Colors.orange,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            _updateShop();
          },
          child: Text(
            "ແກ້ໄຂຮ້ານຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
