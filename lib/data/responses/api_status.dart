import 'package:mvvm_architecture/data/responses/status.dart';

class ApiResponse<T>{

  String? message;
  T? data;
  Status? status;

  ApiResponse(this.message, this.data, this.status);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;


  @override
  String toString(){
    return 'Status: $status \n Message: $message \n Data : $data' ;
  }

}