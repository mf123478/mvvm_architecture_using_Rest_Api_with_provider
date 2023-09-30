import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/app_colors.dart';
import '../res/components/rounded_button.dart';
import '../utils/Routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_modal/auth_repository_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
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
        title: const Text("SignUp"),
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
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, emailFocus, passwordFocus);
            },
          ),

          ValueListenableBuilder(valueListenable: _obsecurePassword,
              builder: (context, value, child) {
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
                          onTap: () {
                            _obsecurePassword.value = !_obsecurePassword.value;
                          },
                          child: _obsecurePassword.value ? const Icon(
                              Icons.visibility_off_outlined) : const Icon(
                              Icons.visibility_outlined))
                  ),
                );
              }),

          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * .1,),
          RoundedButton(
              loading: authViewModel.signUpLoading,
              title: "SignUp", onChanged: () {
            if (emailController.text.isEmpty) {
              Utils.flushBarErrorMessage(
                  "Please fill the Email field", context);
            } else if (passwordController.text.isEmpty) {
              Utils.flushBarErrorMessage(
                  "Please fill the Password field", context);
            } else if (passwordController.text.length < 6) {
              Utils.flushBarErrorMessage(
                  "Password length is less than 6 characters", context);
            } else {
              Map data = {
                "email": emailController.text.toString(),
                "password": passwordController.text.toString()
              };
              authViewModel.signUpApi(data, context);
            }
          }),
          SizedBox(height: MediaQuery.of(context).size.height * .02,),
          InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: const Text("Already have an account? SignUp"))
        ],
      ),
    );
  }
}
