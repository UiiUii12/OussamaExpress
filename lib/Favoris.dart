import 'package:clientapp/Home.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'Login.dart';

class Favoris extends StatefulWidget {
  const Favoris({Key? key}) : super(key: key);

  @override
  State<Favoris> createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.w,
                  ),
                  TextButton(
                    onPressed: () {
                      Main_Page.currentindex = 0;
                      Classe1.classe = Home();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Main_Page()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 28.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
              height: 209.h,
              width: 300.w,
              margin: EdgeInsets.symmetric(horizontal: 57.w),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage('images/Favori.png')))),
          SizedBox(height: 59.h),
          Center(
            child: AutoSizeText(
              '''Oops ! Votre liste est vide 
  Découvrir plus de repas !''',
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 81.h),
          SizedBox(
            width: 200.w,
            height: 60.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Login())); ////////////////////////////////////////
              },
              child: AutoSizeText(
                'Connectez vous',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  primary: Color(0xffffda82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
