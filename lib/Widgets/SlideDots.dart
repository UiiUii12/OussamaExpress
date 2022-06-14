import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget{
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(25),
      height: isActive ? 12 : 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xffF54749) : Color(0xffc4c4c4),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),

    );
  }
}