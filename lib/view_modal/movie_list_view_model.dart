
import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/data/responses/api_status.dart';
import 'package:mvvm_architecture/repository/view_repository.dart';

import '../modal/movie_list_model.dart';

class MovieViewViewModel with ChangeNotifier{


  ApiResponse<MovieListModel> movieList = ApiResponse.loading();

  setMovieList(ApiResponse<MovieListModel> response){
    movieList = response;
    notifyListeners();
  }

  final _myRepo = ViewRepository();

  Future<void> fetchMovieData()async{
    setMovieList(ApiResponse.loading());
    _myRepo.movieListUrl().then((value){
      setMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      setMovieList(ApiResponse.error(error.toString()));
    });
  }
}
