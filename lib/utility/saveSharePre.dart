
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void saveValue( String shareName , String info) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(shareName,info );
}

Future<String> getValue ( String shareName ) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(shareName);
  return data;
}