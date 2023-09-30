 import 'package:flutter/material.dart';
import 'package:mvvm_architecture/res/app_colors.dart';

class RoundedButton extends StatelessWidget {

  String title;
  var onChanged;
  bool loading;

  RoundedButton({super.key, required this.title,required this.onChanged, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.roundButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator(color: Colors.white,) : Text(title),
        ),
      ),
    );
  }
}
