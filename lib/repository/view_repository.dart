
import 'dart:convert';

import 'package:mvvm_architecture/modal/movie_list_model.dart';

import '../data/network/BaseApiConnection.dart';
import '../data/network/NetworkApiConnection.dart';
import '../res/app_url.dart';

class ViewRepository{

  BaseApiConnection _apiServices = NetworkApiConnection();
  
  Future<MovieListModel> movieListUrl()async {
    try{
      var response = await _apiServices.getGetApiRequest(AppUrl.movieEndPoint);
      var data = MovieListModel.fromJson(response);
      return data;
    }catch(e){
      throw e;
    }
  }
  
  
}