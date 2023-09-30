import 'package:flutter/material.dart';
import 'package:mvvm_architecture/view_modal/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices services = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.checkingAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Column(
        children: [
          Center(
            child: Text("Splash Screen",  style:  TextStyle(
              fontSize: 60
            ),),
          )
        ],
      )),
    );
  }
}
