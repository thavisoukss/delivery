import 'dart:ffi';

import 'package:delivery/page/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:delivery/model/getItemBrand.dart';
import 'package:provider/provider.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';

class OnselectListBrand extends StatefulWidget {
  @override
  _OnselectListBrandState createState() => _OnselectListBrandState();
}

class _OnselectListBrandState extends State<OnselectListBrand> {
  List<Data> list_provider;

  Future<Void> get_listItemBrand() async {
    list_provider =
        Provider.of<ItemBrandProvicer>(context, listen: false).listItem;
    print('#####');
    print(list_provider.toString());
    print('#####');
  }

  Future<Void> setItemBrand(Data itemBrandSelect) {
    context.read<ItemBrandProvicer>().addItemBrand(itemBrandSelect);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => AddProduct()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    get_listItemBrand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເລືອກປະເພດສິນຄ້າ'),
      ),
      body: _itemBrand(),
    );
  }

  Widget _itemBrand() {
    return Container(
      //height: 350,
      width: MediaQuery.of(context).size.width,
      child: list_provider == null
          ? Container(
              child: Text('nodata'),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: list_provider.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(list_provider[index].toJson());
                    setItemBrand(list_provider[index]);
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
                                          list_provider[index].bRANDNAME,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
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
