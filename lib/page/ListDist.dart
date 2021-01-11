import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Distribu.dart';
import 'package:delivery/page/CreateUserDist.dart';
import 'package:delivery/page/EditDist.dart';
import 'package:delivery/provider/DistProvider.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListDist extends StatefulWidget {
  @override
  _ListDistState createState() => _ListDistState();
}

class _ListDistState extends State<ListDist> {
  ListDistribu _distribu = null;
  Data _listDist = new Data();

  Future<ListDistribu> getDistribu() async {
    var dio = new Dio();
    try {
      setState(() {
        _loading();
      });
      Response response = await dio.post(
        ShareUrl.getDistributor,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //data: jsonEncode(_postData),
      );
      print(' call api getDistributor');
      setState(() {
        _distribu = ListDistribu.fromJson(response.data);
      });
      _dismiss();
    } on DioError catch (e) {
      print(e);
    }
  }

  _editDist(Data data) async {
    context.read<DistProvider>().addDist(data);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => EdiDist()),
    ).then((value) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => ListDist()));
    });
  }

  _createUser(Data data) async {
    context.read<DistProvider>().addDist(data);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => CreatUSerDist()),
    ).then((value) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => ListDist()));
    });
  }

  _loading() async {
    showLoading(context);
  }

  _dismiss() async {
    Dismiss(context);
  }

  @override
  void initState() {
    getDistribu();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຮ້ານສົ່ງເຄື່ອງທັງໝົດ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _distribu == null
                ? Container(
                    child: Text(''),
                  )
                : _listItem(),
          ],
        ),
      ),
    );
  }

  Widget _listItem() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _distribu.data.length,
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
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                          "ຮ້ານ :  " +
                                              _distribu
                                                  .data[index].dISTRIBUTORNAME,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ),
                                    Container(
                                      child: Text(
                                        "ເບີໂທ :  " +
                                            _distribu.data[index].tELNO,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 35, left: 20),
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
                      caption: 'ແກ້ໄຂ',
                      color: Colors.red,
                      icon: Icons.edit,
                      closeOnTap: false,
                      onTap: () {
                        _editDist(_distribu.data[index]);
                      },
                    ),
                  ),
                  Card(
                    child: IconSlideAction(
                      caption: 'ສ້າງລະຫັດ',
                      color: Colors.green,
                      icon: Icons.account_circle_outlined,
                      closeOnTap: false,
                      onTap: () {
                        _createUser(_distribu.data[index]);
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
