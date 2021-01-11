import 'package:flutter/cupertino.dart';

class LocationProvider extends ChangeNotifier{

  var lat ;
  var lng;

  addCurrentLocation( var lat , var lng){
    this.lat = lat ;
    this.lng = lng;
    notifyListeners();
  }


}