import 'dart:convert';
import 'dart:io';
import 'package:delivery/model/login.dart';
import 'package:delivery/page/CreateDist.dart';
import 'package:delivery/page/buttomNavigation.dart';
import 'package:delivery/page/dashBord.dart';
import 'package:delivery/page/googleMap.dart';
import 'package:delivery/page/register.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/saveSharePre.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isCheck = true;
  UserLogin _userlogin;
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Null> Clear() async {
    userController.text = '';
    passwordController.text = '';
  }

  Future<Null> Login() async {
    var dio = new Dio();
    print('call api');
    var data = {
      "username": userController.text,
      "password": passwordController.text,
      "usertype": "ADMIN"
    };

    var url = "http://178.128.211.32/laoshop/api/login";
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );

      var aa = response.statusCode;
      print(aa);
      var status;
      _userlogin = UserLogin.fromJson(response.data);
      status = _userlogin.status;
      if (status != "success" ||
          userController.text.isEmpty ||
          passwordController.text.isEmpty ||
          response.statusCode != 200) {
        showErrorMessage(context, "user name or password incorrect");
        Clear();
      } else {
        Clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ButtomNavigation()));
      }
    } on DioError catch (e) {
      print(e);
      showErrorMessage(context, "user name or password incorrect");
      Clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _space(height: 50),
                _logos(),
                _space(height: 70),
                _user(),
                _space(height: 20),
                _password(),
                _spaceSmall(),
                _remember(),
                _spaceSmall(),
                _login(),
                _space(height: 40),
                _register(),
                _space(height: 20),
                _registerDis()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logos() {
    return Center(
      child: Container(
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assests/imgs/logos.jpg'),
              ))),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _spaceSmall() {
    return SizedBox(
      height: 5,
    );
  }

  Widget _user() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: userController,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຊື່ຜູ້ໃຊ້',
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

  Widget _password() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລະຫັດຜ່ານ',
            fillColor: Colors.black,
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

  Widget _remember() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text('Remember me'),
          Checkbox(
              value: isCheck,
              checkColor: Colors.yellowAccent, // color of tick Mark
              activeColor: Colors.grey,
              onChanged: (bool value) {
                setState(() {
                  isCheck = value;
                });
              }),
        ],
      ),
    );
  }

  Widget _login() {
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
            //print('aaaa');
            Login();
            //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashbord()));
          },
          child: Text(
            "ເຂົ້າສູ່ລະບົບ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _register() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 50,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.blue)),
          textColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "ລົງທະບຽນຮ້ານຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _registerDis() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 50,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.blue)),
          textColor: Colors.deepOrange,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatDis()));
          },
          child: Text(
            "ລົງທະບຽນຮ້ານສົ່ງສີນຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
