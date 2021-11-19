import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/getItemBrand.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditBrand extends StatefulWidget {
  @override
  _EditBrandState createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  final txt_type = TextEditingController();
  final txt_desc = TextEditingController();
  final txt_item_type = TextEditingController();

  List<Data> ItemBrand;

  File _image;

  _imageFromCamera(context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      //Navigator.of(context).pop();
    });
  }

  Future<void> _getItemBrand() async {
    var ItemBrandID =
        Provider.of<ItemBrandProvicer>(context, listen: false).brandID;
    var postData = {"ID": ItemBrandID};

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.getItemBrand,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        ItemBrand =
            tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        txt_type.text = ItemBrand[0].bRANDNAME;
        txt_desc.text = ItemBrand[0].bRANDDESC;
        txt_item_type.text = ItemBrand[0].iTEMTYPEID.toString();

        print(ItemBrand);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> _update() async {
    var postData = {
      "BRAND_NAME": txt_type.text,
      "BRAND_DESC": txt_desc.text,
      "ITEM_TYPE_ID": ItemBrand[0].iTEMTYPEID,
      "ID": ItemBrand[0].iD
    };

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.updateItemBrand,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );
      var result = response.data;

      if (response.statusCode != 200) {
        showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
        _clearData();
      } else {
        if (result['status'] != 'success') {
          showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
          _clearData();
        } else {
          showSuccessMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດ');
          _clearData();
        }
      }
      print(response.data);
      print(postData);
      _clearData();
    } on DioError catch (e) {
      _clearData();
      print(e);
    }
  }

  _clearData() async {
    txt_type.text = '';
    txt_desc.text = '';
    txt_item_type.text = '';
  }

  _imageGallery(context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
      // Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getItemBrand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເເກ້ໄຂປະເພດສິນຄ້າ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _space(height: 40),
            _pic(),
            _space(height: 20),
            _item_type(),
            _space(height: 20),
            _type(),
            _space(height: 20),
            _detail(),
            _space(height: 20),
            _save()
          ],
        ),
      ),
    );
  }

  Widget _item_type() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          enabled: false,
          controller: txt_item_type,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
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

  Widget _type() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_type,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຊື່ສີນຄ້າ',
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

  Widget _detail() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_desc,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລາຍລະອຽດສີນຄ້າ',
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
            _update();
          },
          child: Text(
            "ແກ້ໄຂສິນຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _pic() {
    return Container(
      child: GestureDetector(
        onTap: () {
          _imageFromCamera(context);
        },
        child: Center(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.blue,
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      _image,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100)),
                    width: 200,
                    height: 200,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }
}
