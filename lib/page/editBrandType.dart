import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/ItemType.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditBrandType extends StatefulWidget {
  @override
  _EditBrandTypeState createState() => _EditBrandTypeState();
}

class _EditBrandTypeState extends State<EditBrandType> {
  final txt_type = TextEditingController();
  final txt_desc = TextEditingController();
  List<Data> _listItemType;
  var ItemTypeId;
  File _image;

  _imageFromCamera(context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      //Navigator.of(context).pop();
    });
  }

  _clear() {
    txt_desc.text = '';
    txt_type.text = '';
  }

  Future<void> _edittItemType() async {
    var _postData = {
      "ID": ItemTypeId,
      "ITEM_TYPE_NAME": txt_type.text,
      "ITEM_TYPE_DESC": txt_desc.text,
      "CATEGORY_ID": 1
    };
    print(_postData);

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.updateItemType,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(_postData),
      );
      var result = response.data;

      if (response.statusCode != 200) {
        showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
        _clear();
      } else {
        if (result['status'] != 'success') {
          showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
          _clear();
        } else {
          showSuccessMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດ');
          _clear();
        }
      }
    } on DioError catch (e) {
      print(e);
      showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
      _clear();
    }
  }

  Future<void> _getItemType() async {
    ItemTypeId =
        Provider.of<ItemBrandProvicer>(context, listen: false).ItemTypeID;
    var postData = {"ID": ItemTypeId};

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.getItemType,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        _listItemType =
            tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        print(_listItemType.toString());
        txt_type.text = _listItemType[0].iTEMTYPENAME;
        txt_desc.text = _listItemType[0].iTEMTYPEDESC;
        ItemTypeId = _listItemType[0].iD;
      });
    } on DioError catch (e) {
      print(e);
    }
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
    _getItemType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ເເກ້ໄຂກູ່ມສິນຄ້າ'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _space(height: 40.0),
              _pic(),
              _space(height: 20.0),
              _type(),
              _space(height: 20),
              _detail(),
              _space(height: 20.0),
              _edit(),
            ],
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
            labelText: 'ປ້ອນຊື່ກູ່ມສິນຄ້າ',
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
            labelText: 'ປ້ອນລາຍລະອຽດກູ່ມສິນຄ້າ',
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

  Widget _edit() {
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
            _edittItemType();
          },
          child: Text(
            "ເເກ້ໄຂກູ່ມສິນຄ້າ".toUpperCase(),
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
