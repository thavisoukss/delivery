import 'dart:convert';
import 'dart:io';
import 'package:delivery/page/dashBord.dart';
import 'package:delivery/page/editBrand.dart';
import 'package:delivery/widget/ListItem.dart';
import 'package:provider/provider.dart';
import 'package:delivery/model/getItemBrand.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListMenu extends StatefulWidget {
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  GetItemBrand getItemBrand;

  List<Data> datas;

  Future<void> _getItemBrand() async {
    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.getItemBrand,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(data),
      );
      getItemBrand = GetItemBrand.fromJson(response.data);

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        datas = tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        print(datas);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  _editBrand(var itemID) async {
    context.read<ItemBrandProvicer>().addBrand(itemID);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EditBrand()),
    ).then((value) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Dashbord()));
    });
  }

  _postBrandID(var brandID) async {
    context.read<ItemBrandProvicer>().addBrand(brandID);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ListItem()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItemBrand();
  }

  @override
  Widget build(BuildContext context) {
    return _product();
  }

  Widget _product() {
    return Container(
        height: 350,
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
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          _postBrandID(datas[index].iD);
                        },
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
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              datas[index].bRANDNAME,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
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
                            var itemID = datas[index].iD;
                            _editBrand(itemID);
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
