import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Distribu.dart';
import 'package:delivery/provider/DistProvider.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatUSerDist extends StatefulWidget {
  @override
  _CreatUSerDistState createState() => _CreatUSerDistState();
}

class _CreatUSerDistState extends State<CreatUSerDist> {
  final txtUser = TextEditingController();
  final txtPassword = TextEditingController();

  Data resDis = new Data();
  Future<void> getListDist() async {
    setState(() {
      resDis = Provider.of<DistProvider>(context, listen: false).resDist;
    });
  }

  _createUser() async {
    var _postData = {
      "USERNAME": txtUser.text,
      "PASSWORD": txtPassword.text,
      "STATUS": "ACTIVE",
      "USER_TYPE": "DISTRIBUTOR",
      "SHOP_ID": resDis.iD,
      "SHOP_NAME": resDis.dISTRIBUTORNAME
    };

    var dio = new Dio();
    try {
      setState(() {
        _loading();
      });
      Response response = await dio.post(
        ShareUrl.createUser,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(_postData),
      );
      var result = response.data;
      print(' call api Create user');
      print(result);

      if (response.statusCode != 200) {
        _dismiss();
        _clear();
        showErrorMessage(context, 'ສ້າງລະຫັດຜ່ານບໍ່ສຳເລັດ');
      } else {
        if (result['status'] != 'success') {
          _dismiss();
          _clear();
          showErrorMessage(context, 'ສ້າງລະຫັດຜ່ານບໍ່ສຳເລັດ');
        } else {
          _dismiss();
          _clear();
          showSuccessMessage(context, 'ສ້າງລະຫັດຜ່ານສຳເລັດ');
        }
      }
    } on DioError catch (e) {
      print(e);
      _dismiss();
      _clear();
      showErrorMessage(context, 'ສ້າງລະຫັດຜ່ານບໍ່ສຳເລັດ');
    }
  }

  _loading() async {
    showLoading(context);
  }

  _dismiss() async {
    Dismiss(context);
  }

  _clear() async {
    txtUser.text = '';
    txtPassword.text = '';
  }

  @override
  void initState() {
    getListDist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ສ້າງລະຫັດຜ່ານ'),
      ),
      body: Column(
        children: [
          _space(height: 30),
          _user(),
          _space(height: 20),
          _pass(),
          _space(height: 30),
          _save()
        ],
      ),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _user() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtUser,
          decoration: InputDecoration(
            labelText: 'ຊື່ຜູ້ໃຊ້',
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

  Widget _pass() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtPassword,
          decoration: InputDecoration(
            labelText: 'ລະຫັດຜ່ານ',
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
            _createUser();
          },
          child: Text(
            "ສ້າງລະຫັດຜ່ານ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
