import 'dart:convert';
import 'dart:io';
import 'package:delivery/model/ItemType.dart';
import 'package:delivery/page/buttomNavigation.dart';
import 'package:delivery/page/dashBord.dart';
import 'package:delivery/page/editBrandType.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListType extends StatefulWidget {
  @override
  _ListTypeState createState() => _ListTypeState();
}

class _ListTypeState extends State<ListType> {
  ItemType itemType;
  List<Data> datas;

  Future<void> _getitemType() async {
    var dio = new Dio();
    print('call api');

    Response response = await dio.post(
      ShareUrl.getItemType,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
    );
    var tagObjsJson = jsonDecode(response.toString())['data'] as List;

    setState(() {
      datas = tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
    });
    print(datas);
    print(response);
  }

  _editItemType(itemTypeID) async {
    print(itemTypeID);
    context.read<ItemBrandProvicer>().addItemTypeID(itemTypeID);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EditBrandType()),
    ).then((value) => {
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => ButtomNavigation()))
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getitemType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return datas == null ? Container(child: Text('')) : _productType();
  }
  // widget

  Widget _productType() {
    return Container(
      height: 160,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: datas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                var itemTypeID = datas[index].iD;
                _editItemType(itemTypeID);
              },
              child: Container(
                height: 160,
                width: 160,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          child: Text(
                            datas[index].iTEMTYPENAME,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            );
          }),
    );
  }
}
