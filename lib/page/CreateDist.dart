import 'dart:convert';
import 'dart:io';

import 'package:delivery/page/LocationShop.dart';
import 'package:delivery/provider/locationProvider.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatDis extends StatefulWidget {
  @override
  _CreatDisState createState() => _CreatDisState();
}

class _CreatDisState extends State<CreatDis> {
  final txtDisName = TextEditingController();
  final txtAddress = TextEditingController();
  final txtTelNo = TextEditingController();
  final txtDisType = TextEditingController();
  final txtAcc1 = TextEditingController();
  final txtAcc2 = TextEditingController();
  final txtAcc3 = TextEditingController();
  final txtAccName1 = TextEditingController();
  final txtAccName2 = TextEditingController();
  final txtAccName3 = TextEditingController();

  _clear() {
    txtDisName.text = '';
    txtAddress.text = '';
    txtTelNo.text = '';
    txtDisType.text = '';
    txtAcc1.text = '';
    txtAcc2.text = '';
    txtAcc3.text = '';
    txtAccName1.text = '';
    txtAccName2.text = '';
    txtAccName3.text = '';
  }

  _addDis() async {
    var lat;
    var lng;
    lat = Provider.of<LocationProvider>(context, listen: false).lat;
    lng = Provider.of<LocationProvider>(context, listen: false).lng;

    var _postData = {
      "DISTRIBUTOR_NAME": txtDisName.text,
      "ADDRESS": txtAddress.text,
      "TEL_NO": txtTelNo.text,
      "DISTRIBUTOR_TYPE": txtDisType.text,
      "LOCATION": txtAddress.text,
      "STATUS": "ACTIVE",
      "ACCOUNT_NUMBER1": txtAcc1.text,
      "ACCOUNT_NUMBER2": txtAcc2.text,
      "ACCOUNT_NUMBER3": txtAcc3.text,
      "ACCOUNT_NAME1": txtAccName1.text,
      "ACCOUNT_NAME2": txtAccName2.text,
      "ACCOUNT_NAME3": txtAccName3.text,
      "LASTS": 192.01,
      "LONGS": 192.01,
      "TOKEN": "null"
    };

    var dio = new Dio();
    try {
      setState(() {
        _loading();
      });
      Response response = await dio.post(
        ShareUrl.creatDistributor,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(_postData),
      );
      var result = response.data;
      print(' call api creatDistributor');
      print(result);

      if (response.statusCode != 200) {
        _dismiss();
        _clear();
        showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
      } else {
        if (result['status'] != 'success') {
          _dismiss();
          _clear();
          showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
        } else {
          _dismiss();
          _clear();
          showSuccessMessage(context, 'ບັນທຶກຂໍ້ມູນສຳເລັດ');
        }
      }
    } on DioError catch (e) {
      print(e);
      _dismiss();
      _clear();
      showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
    }
  }

  _loading() async {
    showLoading(context);
  }

  _dismiss() async {
    Dismiss(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ລົງທະບຽນຮ້ານຄ້າ')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _space(height: 30),
            _disName(),
            _space(height: 15),
            _address(),
            _space(height: 15),
            _telNo(),
            _space(height: 15),
            _disType(),
            _space(height: 15),
            _account1(),
            _space(height: 15),
            _account2(),
            _space(height: 15),
            _account3(),
            _space(height: 15),
            _accName1(),
            _space(height: 15),
            _accName2(),
            _space(height: 15),
            _accName3(),
            _space(height: 15),
            _location(),
            _space(height: 15),
            _save()
          ],
        ),
      ),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _locationShop = LocationShop();

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

  Widget _disName() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtDisName,
          decoration: InputDecoration(
            labelText: 'ຊື່ຮ້ານ',
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
          controller: txtAddress,
          decoration: InputDecoration(
            labelText: 'ສະຖານທີ່ຮ້ານ',
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

  Widget _telNo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtTelNo,
          decoration: InputDecoration(
            labelText: 'ເບີໂທ',
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

  Widget _disType() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtDisType,
          decoration: InputDecoration(
            labelText: 'ປະເພດຮ້ານ',
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

  Widget _account1() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAcc1,
          decoration: InputDecoration(
            labelText: 'ເລກບັນຊີ1',
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

  Widget _account2() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAcc2,
          decoration: InputDecoration(
            labelText: 'ເລກບັນຊີ2',
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

  Widget _account3() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAcc3,
          decoration: InputDecoration(
            labelText: 'ເລກບັນຊີ3',
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

  Widget _accName1() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAccName1,
          decoration: InputDecoration(
            labelText: 'ຊື່ເລກບັນຊີ1',
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

  Widget _accName2() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAccName2,
          decoration: InputDecoration(
            labelText: 'ຊື່ເລກບັນຊີ2',
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

  Widget _accName3() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txtAccName3,
          decoration: InputDecoration(
            labelText: 'ຊື່ເລກບັນຊີ3',
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
            _addDis();
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
