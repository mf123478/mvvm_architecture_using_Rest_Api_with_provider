import 'package:flutter/material.dart';
import 'package:mvvm_architecture/res/app_colors.dart';
import 'package:mvvm_architecture/res/components/rounded_button.dart';
import 'package:mvvm_architecture/utils/Routes/routes.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/utils/utils.dart';
import 'package:mvvm_architecture/view_modal/auth_repository_view_model.dart';
import 'package:mvvm_architecture/view_modal/user_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    _obsecurePassword.dispose();
  }

  @override

  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 2,
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
         TextFormField(
           focusNode: emailFocus,
           controller: emailController,
           keyboardType: TextInputType.emailAddress,
           decoration: const InputDecoration(
             hintText: 'Email',
             labelText: 'Email',
             prefixIcon: Icon(Icons.alternate_email),
           ),
           onFieldSubmitted: (value){
             Utils.fieldFocusChange(context, emailFocus, passwordFocus);
           },
         ),

        ValueListenableBuilder(valueListenable: _obsecurePassword, builder: (context,value, child){
          return TextFormField(
            focusNode: passwordFocus,
            controller: passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: _obsecurePassword.value,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: InkWell(
                    onTap: (){
                      _obsecurePassword.value = !_obsecurePassword.value;
                    },
                    child: _obsecurePassword.value ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined))
            ),
          );
        }),

        SizedBox(height: MediaQuery.of(context).size.height*.1,),
        RoundedButton(
            loading: authViewModel.loading,
            title: "Login", onChanged: (){
          if(emailController.text.isEmpty){
            Utils.flushBarErrorMessage("Please fill the Email field", context);
          }else if(passwordController.text.isEmpty){
            Utils.flushBarErrorMessage("Please fill the Password field", context);
          }else if(passwordController.text.length < 6){
            Utils.flushBarErrorMessage("Password length is less than 6 characters", context);
          }else{
            Map data = {
              "email" : emailController.text.toString(),
              "password" : passwordController.text.toString()
            };
            authViewModel.loginApi(data, context);
          }
        }),
        SizedBox(height: MediaQuery.of(context).size.height * .02,),
        InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.signUp);
            },
            child: const Text("Don't have an Account? SignUp"))
        ],
      ),
    );
  }
}
