import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Home.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Commandearive extends StatefulWidget {
  const Commandearive({Key? key}) : super(key: key);

  @override
  State<Commandearive> createState() => _CommandeariveState();
}

class _CommandeariveState extends State<Commandearive> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(height: 70.h,) ,
                Container(
                  height: 200.h,
                  width: 300.w,
                  margin: EdgeInsets.symmetric(horizontal: 57.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/commande est là.png"),
                    ),
                  ),
                ),
                SizedBox(height: 70.h,) ,
                SizedBox(
                  width: 350.w,
                  child: AutoSizeText(
                    '''Votre commande est là !
Veuillez la collecter''',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    //  minFontSize: 22.sp,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      //  fontWeight: FontWeight.bold ,
                    ),
                  ),
                ),
                SizedBox(
                  height:150.h,
                ),
                SizedBox(
                  width: 200.w,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Classe1.classe=Home();
                      Main_Page.currentindex=0;
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Main_Page()));
                    },
                    child: AutoSizeText(
                      "C'est parti",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey,
                        primary: Color(0xffffda82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),


              ],
            ),
          ));
  }
}
