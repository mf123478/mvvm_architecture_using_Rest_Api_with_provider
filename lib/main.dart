import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/Routes/routes.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/view/login_screen.dart';
import 'package:mvvm_architecture/view_modal/auth_repository_view_model.dart';
import 'package:mvvm_architecture/view_modal/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
          home: const LoginScreen(),
        ));
  }
}
