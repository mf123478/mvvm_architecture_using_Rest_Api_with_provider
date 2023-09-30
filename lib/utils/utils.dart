

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static double averageRating(List<int> ratings){

    var avgRating = 0;

    for(int i = 0 ; i < ratings.length ; i++ ){
      avgRating = avgRating + ratings[i];
    }
    return double.parse((avgRating/ratings.length).toStringAsFixed(1));
  }


  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.warning_rounded),
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
    )..show(context));
  }

  static snackBarErrorMessage(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


}