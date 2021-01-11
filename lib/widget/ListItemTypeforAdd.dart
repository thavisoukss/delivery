import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/ItemType.dart';
import 'package:delivery/page/AddBrand.dart';
import 'package:delivery/page/editBrand.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListItemTypeforAdd extends StatefulWidget {
  @override
  _ListItemTypeforAddState createState() => _ListItemTypeforAddState();
}

class _ListItemTypeforAddState extends State<ListItemTypeforAdd> {
  ItemType itemType;
  List<Data> datas;
  List<Data> result;

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

  Future<void> _getItemTypeByID(int id) async {
    var _postData = {"ID": id};
    var dio = new Dio();
    print('call api');

    Response response = await dio.post(
      ShareUrl.getItemType,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(_postData),
    );
    var tagObjsJson = jsonDecode(response.toString())['data'] as List;

    setState(() {
      result = tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
    });

    context.read<ItemBrandProvicer>().AddItemType(result);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AddBrand()),
    );
  }

  _editBrand(var itemID) async {
    context.read<ItemBrandProvicer>().addBrand(itemID);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EditBrand()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getitemType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ເລືອກກູ່ມສິນຄ້າ'),
        ),
        body: _listType());
  }

  Widget _listType() {
    return Container(
      //height: 350,
      width: MediaQuery.of(context).size.width,
      child: datas == null
          ? Container(
              child: Text(''),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: datas.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(index),
                  child: GestureDetector(
                    onTap: () {
                      print(datas[index].iD);
                      _getItemTypeByID(datas[index].iD);
                    },
                    child: Container(
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                //child: Image.asset('assests/imgs/beer.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            datas[index].iTEMTYPENAME,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 35, left: 50),
                                child: Container(
                                    child: Icon(
                                  Icons.arrow_right,
                                  size: 50,
                                  color: Colors.grey,
                                )),
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
                      child: IconSlideAction(
                        caption: 'update',
                        color: Colors.red,
                        icon: Icons.edit,
                        closeOnTap: false,
                        onTap: () {
                          var itemID = datas[index].iD;
                          _editBrand(itemID);
                        },
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
