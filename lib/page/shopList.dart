import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Shop.dart';
import 'package:delivery/page/CreateUserShop.dart';
import 'package:delivery/page/editShop.dart';
import 'package:delivery/provider/shopProvider.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  Shop shop;
  List<Data> data;

  _getAllShop() async {
    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.getShop,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(data),
      );
      shop = Shop.fromJson(response.data);

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        data = tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        print(data);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  _editItem(Data item) async {
    context.read<ShopProvider>().addShop(item);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EditShop()),
    ).then((value) {
      setState(() {
        _getAllShop();

        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => ShopList()),
        );
      });
    });
  }

  _creatUser(Data item) async {
    context.read<ShopProvider>().addShop(item);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => CreateUserShop()),
    ).then((value) {
      setState(() {
        _getAllShop();

        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(builder: (context) => ShopList()),
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getAllShop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການຮ້ານທັງໝົດ'),
      ),
      body: _listItem(),
    );
  }

  Widget _listItem() {
    return Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: data == null
            ? Container(
                child: Text(''),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    child: Container(
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "ຮ້ານ :  " + data[index].sHOPNAME,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "ເບີໂທ :  " +
                                                data[index].tELNO.toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "ສະຖານທີ່ :  " +
                                                data[index].sHOPADDRESS,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 35, left: 20),
                                  child: Container(
                                    child: Text(''),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                      ),
                    ),
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      Card(
                        child: SlideAction(
                          child: GestureDetector(
                            onTap: () {
                              _editItem(data[index]);
                            },
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.orange,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Text(
                                        'ແກ້ໄຂ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Card(
                        child: SlideAction(
                          child: GestureDetector(
                            onTap: () {
                              _creatUser(data[index]);
                            },
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.green,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Text(
                                        'ສ້າງລະຫັດຜ່ານ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                  );
                }));
  }
}
