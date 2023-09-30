
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/view_modal/user_view_model.dart';

import '../../modal/user_model.dart';

class SplashServices{

  Future<UserModel> getUserData() async{
    return UserViewModel().getUser();
  }

  void checkingAuth(BuildContext context)async{
    getUserData().then((value)async{
      print("Object object object $value");
      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode){
        print(error);
      }
    });
  }
}