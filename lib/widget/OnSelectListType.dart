import 'dart:convert';
import 'dart:io';
import 'package:delivery/model/ItemType.dart';
import 'package:delivery/model/getItemBrand.dart' as item;
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/widget/OnSelectListBrand.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OnSelectListType extends StatefulWidget {
  @override
  _OnSelectListTypeState createState() => _OnSelectListTypeState();
}

class _OnSelectListTypeState extends State<OnSelectListType> {
  ItemType itemType;
  List<Data> datas;

  item.GetItemBrand getItemBrand;
  List<item.Data> rsult;

  Future<void> _getitemType() async {
    var dio = new Dio();
    print('call api');

    var url = "http://178.128.211.32/laoshop/api/getItemType";
    Response response = await dio.post(
      url,
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

  Future<void> _getitemBrandByID(int item_id) async {
    var dio = new Dio();
    print('call api');

    var data = {"ITEM_TYPE_ID": item_id};

    var url = "http://178.128.211.32/laoshop/api/getItemBrand";
    Response response = await dio.post(
      url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(data),
    );
    var res_item = jsonDecode(response.toString())['data'] as List;
    print(res_item);

    rsult = res_item.map((tagJson) => item.Data.fromJson(tagJson)).toList();
    context.read<ItemBrandProvicer>().addListItemBrand(rsult);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => OnselectListBrand()),
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
      body: _product(),
    );
  }

  Widget _product() {
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
                return GestureDetector(
                  onTap: () {
                    print(datas[index].iD);
                    _getitemBrandByID(datas[index].iD);
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
                                  borderRadius: BorderRadius.circular(50)),
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
                              padding: const EdgeInsets.only(top: 35, left: 50),
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
                );
              }),
    );
  }
}
