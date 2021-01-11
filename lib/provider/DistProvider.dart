import 'package:delivery/model/Distribu.dart';
import 'package:flutter/cupertino.dart';

class DistProvider extends ChangeNotifier {
  Data resDist = new Data();

  addDist(Data data) {
    this.resDist = data;
    notifyListeners();
  }
}
