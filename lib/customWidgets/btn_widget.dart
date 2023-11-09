import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final Function()? onTap;
  const BtnWidget({super.key, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Center(
          child: Text("Sign In",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),),
        ),
      ),
    );
  }
}
