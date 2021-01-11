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

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {

  List<Data> listItemType_provider;

  Future<void> get_listItemBrand() async{

    listItemType_provider = Provider.of<ItemBrandProvicer>(context,listen: false).listItemType;
    print('#####');
    print(listItemType_provider.toString());
    print('#####');
    setState(() {
      txt_item_type.text = listItemType_provider[0].iTEMTYPENAME;
      id = listItemType_provider[0].iD;
    });
  }


  final txt_type = TextEditingController();
  final txt_desc = TextEditingController();
  final txt_item_type  = TextEditingController();
   int id;

  File _image;

  _imageFromCamera(context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
      //Navigator.of(context).pop();
    });
  }

  _imageGallery(context) async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
      // Navigator.of(context).pop();
    });
  }

  _setImageToNull() async {
    _image = null;
  }

  Future<void> _postItemType() async {
    var _postData = {
      "BRAND_NAME": txt_type.text,
      "BRAND_DESC": txt_desc.text,
      "ITEM_TYPE_ID": id
    };

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.createItemBrand,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(_postData),
      );
      var result = response.data;

      if (response.statusCode != 200) {
        showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
      } else {
        if (result['status'] != 'success') {
          showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
        } else {
          showSuccessMessage(context, 'ເພີ່ມສິນຄ້າສຳເລັດ');
        }
      }
    } on DioError catch (e) {
      print(e);
      showErrorMessage(context, 'ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ');
    }
  }


  _clearData(){
    txt_desc.text = '';
    txt_type.text = '';
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
        title: Text('ເພີ່ມສິນຄ້າ'),
      ),body:  SingleChildScrollView(
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
      )
    );
  }

  Widget _item_type() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
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


  Widget _type(){
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

  Widget _detail(){
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

  Widget _save(){
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
            _postItemType();
            _clearData();
          },
          child: Text(
            "ເພີ່ມສິນຄ້າ".toUpperCase(),
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
