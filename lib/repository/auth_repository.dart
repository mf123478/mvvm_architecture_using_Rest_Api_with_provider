
import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/data/network/BaseApiConnection.dart';
import 'package:mvvm_architecture/data/network/NetworkApiConnection.dart';
import 'package:mvvm_architecture/res/app_url.dart';
import 'package:mvvm_architecture/utils/utils.dart';

class AuthRepository{

  BaseApiConnection _apiServices = NetworkApiConnection();

  Future<dynamic> loginApi(dynamic data)async {
    try{
      var response = await _apiServices.getPostApiRequest(AppUrl.loginUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data)async {
    try{
      var response = await _apiServices.getPostApiRequest(AppUrl.registerUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }


}