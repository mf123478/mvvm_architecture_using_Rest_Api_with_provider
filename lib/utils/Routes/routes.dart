
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/view/home_screen.dart';
import 'package:mvvm_architecture/view/login_screen.dart';
import 'package:mvvm_architecture/view/signup_screen.dart';
import 'package:mvvm_architecture/view/splash_screen.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
              child: Text("No such route found"),
            ),
          );
        });
    }
  }


}