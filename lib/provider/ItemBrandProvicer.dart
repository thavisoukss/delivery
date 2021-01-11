import 'package:delivery/model/ItemType.dart' as itemType;
import 'package:delivery/model/getItemBrand.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivery/model/Item.dart' as itemDetail;

class ItemBrandProvicer extends ChangeNotifier {
  List<itemType.Data> listItemType;
  List<Data> listItem = [];
  var brandID;
  var ItemID;
  Data itemBarnd;
  var ItemTypeID;

  addListItemBrand(List<Data> item) {
    this.listItem = item;
    notifyListeners();
  }

  addItemBrand(Data item) {
    this.itemBarnd = item;
    notifyListeners();
  }

  AddItemType(List<itemType.Data> item) {
    this.listItemType = item;
    notifyListeners();
  }

  addBrand(var brand_id) {
    this.brandID = brand_id;
    notifyListeners();
  }

  addItem(var item_id) {
    this.ItemID = item_id;
    notifyListeners();
  }

  addItemTypeID(var itemTypeID) {
    this.ItemTypeID = itemTypeID;
    notifyListeners();
  }
}
