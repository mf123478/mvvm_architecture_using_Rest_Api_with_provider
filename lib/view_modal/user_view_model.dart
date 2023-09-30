
import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/modal/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{


  Future<bool> saveUser(UserModel user) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", user.token.toString());
    notifyListeners();
    return true;
  }


  Future<UserModel> getUser()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    print('object object object $token');
    return UserModel(
      token: token
    );
  }

  Future<bool>logOut()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove("token");
    print("success");
    return  true;
  }




}