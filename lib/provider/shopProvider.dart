import 'package:delivery/model/Shop.dart';
import 'package:flutter/cupertino.dart';

class ShopProvider extends ChangeNotifier {
  Data data;

  addShop(Data item) {
    this.data = item;
    notifyListeners();
  }
}
