import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Item.dart';
import 'package:delivery/page/editItem.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ListItem extends StatefulWidget {
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Item item;
  List<Data> data;

  Future<void> _getItemById() async {
    var dio = new Dio();
    var ItemBrandID =
        Provider.of<ItemBrandProvicer>(context, listen: false).brandID;
    print(ItemBrandID);
    var postData = {"ITEM_TYPE_ID": ItemBrandID};
    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );
      item = Item.fromJson(response.data);

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        data = tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        print(data.toString());
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  _editItem(var itemID) async {
    context.read<ItemBrandProvicer>().addItem(itemID);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EditItem()),
    ).then((value) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => ListItem()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getItemById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍການສິນຄ້າ'),
      ),
      body: _listItem(),
    );
  }

  Widget _listItem() {
    return Container(
        height: 350,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                //child: Image.asset('assests/imgs/beer.png'),
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
                                              "ສິນຄ້າ :  " +
                                                  data[index].iTEMNAME,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        ),
                                        Container(
                                          child: Text(
                                            "ລາຄາ :  " +
                                                NumberFormat().format(
                                                    data[index].iTEMPRICE) +
                                                "  " +
                                                data[index].iTEMCCY.toString(),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
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
                        child: IconSlideAction(
                          caption: 'update',
                          color: Colors.red,
                          icon: Icons.edit,
                          closeOnTap: false,
                          onTap: () {
                            var itemID = data[index].iD;
                            _editItem(itemID);
                          },
                        ),
                      )
                    ],
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                  );
                }));
  }
}
