
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm_architecture/data/app_exceptions.dart';
import 'package:mvvm_architecture/data/network/BaseApiConnection.dart';
import 'package:http/http.dart' as http;

class NetworkApiConnection extends BaseApiConnection{

  @override
  Future getGetApiRequest(url) async {
    dynamic responseJson;
    try{

       final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
       responseJson = returnResponse(response);
    } on SocketException{
      throw FetchDataException("Connection Problem");
    }
    return responseJson;
  }

  @override
  Future getPostApiRequest(url, dynamic data) async {

    dynamic responseJson;

    try{

      http.Response response = await http.post(Uri.parse(url),
        body: data
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);

    }on SocketException{
      throw FetchDataException("Connection Error");
    }

    return responseJson;


  }

  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("Connection Problem");
      case 404:
        throw UnauthorisedException(response.body.toString());
      default :
        throw FetchDataException("Error occured while connecting to the server with status code ${response.body.toString()}");

    }

  }

}





