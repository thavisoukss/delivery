import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/page/dashBord.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        )
      ],
    ),
  );
}

//Future<void> showErrorMessage(BuildContext context , String message){
//  SweetAlert.show(context,
//      title: "Error",
//      subtitle: message,
//      style: SweetAlertStyle.error);
//}

//Future<void> showSuccessMessage(BuildContext context , String message){
//  SweetAlert.show(context,
//      title: "Success",
//      subtitle: message,
//      style: SweetAlertStyle.success);
//}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

Future<void> showLoading(BuildContext context) {
  EasyLoading.instance
    ..backgroundColor = Colors.red
    ..indicatorColor = Colors.transparent
    ..maskColor = Colors.red
    ..userInteractions = false;

  EasyLoading.show(status: 'loadning');
}

Future<void> Dismiss(BuildContext context) {
  EasyLoading.dismiss();
}

showSuccessMessage(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    dialogType: DialogType.SUCCES,
    body: Center(
      child: Text(message),
    ),
    autoHide: Duration(seconds: 5),
  )..show();
}

showErrorMessage(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    animType: AnimType.TOPSLIDE,
    dialogType: DialogType.ERROR,
    body: Center(
      child: Text(message),
    ),
    autoHide: Duration(seconds: 5),
  )..show();
}
