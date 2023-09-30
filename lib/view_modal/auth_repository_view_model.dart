
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_architecture/modal/user_model.dart';
import 'package:mvvm_architecture/repository/auth_repository.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/utils/utils.dart';
import 'package:mvvm_architecture/view_modal/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }


  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context)async{
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      Utils.flushBarErrorMessage('login Successful', context);
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token']
        )
      );
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage( error.toString(), context);
        print(error.toString());
      }

    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context)async{
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value){
      Utils.flushBarErrorMessage('SignUp Successful', context);
      setSignUpLoading(false);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      if(kDebugMode){
        Utils.flushBarErrorMessage( error.toString(), context);
        print(error.toString());
      }
    });
  }
}