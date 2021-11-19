import 'dart:convert';
import 'dart:io';

import 'package:delivery/model/Item.dart';
import 'package:delivery/provider/ItemBrandProvicer.dart';
import 'package:delivery/utility/normalDialog.dart';
import 'package:delivery/utility/shareUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditItem extends StatefulWidget {
  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final txt_item_code = TextEditingController();
  final txt_item_type = TextEditingController();
  final txt_item_barcode = TextEditingController();
  final txt_item_name = TextEditingController();
  final txt_item_desc = TextEditingController();
  final txt_item_price = TextEditingController();
  final txt_item_ccy = TextEditingController();
  final txt_unit_id = TextEditingController();
  final txt_unit_name = TextEditingController();

  File _image;
  List<Data> listItem;

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

  Future<void> _getItemBrand() async {
    var ItemBrandID =
        Provider.of<ItemBrandProvicer>(context, listen: false).ItemID;
    var postData = {"ID": ItemBrandID};

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.getItem,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(postData),
      );

      var tagObjsJson = jsonDecode(response.toString())['data'] as List;

      setState(() {
        listItem =
            tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();
        print(listItem.toString());
        txt_item_code.text = listItem[0].iTEMBARCODE;
        txt_item_type.text = listItem[0].iTEMTYPENAME;
        txt_item_barcode.text = listItem[0].iTEMBARCODE;
        txt_item_name.text = listItem[0].iTEMNAME;
        txt_item_desc.text = listItem[0].iTEMDESC;
        txt_item_price.text = listItem[0].iTEMPRICE.toString();
        txt_item_ccy.text = listItem[0].iTEMCCY;
        txt_unit_name.text = listItem[0].uNITNAME;
        txt_unit_id.text = listItem[0].uNITID.toString();
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  _clear() {
    txt_item_code.text = '';
    txt_item_type.text = '';
    txt_item_barcode.text = '';
    txt_item_name.text = '';
    txt_item_desc.text = '';
    txt_item_price.text = '';
    txt_item_ccy.text = '';
    txt_unit_id.text = '';
    txt_unit_name.text = '';
  }

  Future<void> _postItem() async {
    var _postData = {
      "ID": listItem[0].iD,
      "ITEM_CODE": txt_item_code.text,
      "ITEM_BARCODE": txt_item_barcode.text,
      "ITEM_NAME": txt_item_name.text,
      "ITEM_DESC": txt_item_desc.text,
      "ITEM_PRICE": txt_item_price.text,
      "ITEM_CCY": txt_item_ccy.text,
      "UNIT_ID": txt_unit_id.text,
      "UNIT_NAME": txt_unit_name.text,
      "ITEM_TYPE_ID": listItem[0].iTEMTYPEID,
      "ITEM_TYPE_NAME": listItem[0].iTEMTYPENAME,
      "PIC_NAME": "http://23434324"
    };
    print(_postData);

    var dio = new Dio();
    try {
      Response response = await dio.post(
        ShareUrl.updateItem,
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
        title: Text('ເເກ້ໄຂລາຍການສິນຄ້າ'),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            _space(height: 40.0),
            pic(),
            _space(height: 20.0),
            _product()
          ],
        )),
      ),
    );
  }

  Widget _product() {
    return Container(
        child: Column(
      children: [
        _space(height: 20.0),
        _item_type(),
        _space(height: 20.0),
        _item_code(),
        _space(height: 20.0),
        _item_barcode(),
        _space(height: 20.0),
        _item_name(),
        _space(height: 20.0),
        _item_desc(),
        _space(height: 20.0),
        _item_price(),
        _space(height: 20.0),
        _item_ccy(),
        _space(height: 20.0),
        _unit_id(),
        _space(height: 20.0),
        _unit_name(),
        _space(height: 30.0),
        _login(),
      ],
    ));
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

  Widget _item_code() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_item_code,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລະຫັດສິນຄ້າ',
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

  Widget _item_barcode() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_item_barcode,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລະຫັດບາໂຄດ',
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

  Widget _item_name() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_item_name,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຊື່ສິນຄ້າ',
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

  Widget _item_desc() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_item_desc,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລາຍລະອຽດສິນຄ້າ',
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

  Widget _item_price() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          keyboardType: TextInputType.number,
          controller: txt_item_price,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລາຄາສິນຄ້າ',
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

  Widget _item_ccy() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_item_ccy,
          decoration: InputDecoration(
            labelText: 'ປ້ອນສະກຸນເງີນ',
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

  Widget _unit_id() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_unit_id,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຈຳນວນສິນຄ້າ',
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

  Widget _unit_name() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: txt_unit_name,
          decoration: InputDecoration(
            labelText: 'ປ້ອນ',
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

  Widget pic() {
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

  Widget _login() {
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
            _postItem();
          },
          child: Text(
            "ເເກ້ໄຂສິນຄ້າ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
