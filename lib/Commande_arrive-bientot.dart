import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Home.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Commande_arivée.dart';

class CommandeariveBeintot extends StatefulWidget {
  const CommandeariveBeintot({Key? key}) : super(key: key);

  @override
  State<CommandeariveBeintot> createState() => _CommandeariveBeintot();
}

class _CommandeariveBeintot extends State<CommandeariveBeintot> {
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          Icon(
                            Icons.arrow_back,
                            size: 28.sp,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,) ,
                Container(
                  height: 200.h,
                  width: 300.w,
                  margin: EdgeInsets.symmetric(horizontal: 57.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/Commande arrive bientot.png"),
                    ),
                  ),
                ),
                SizedBox(height: 50.h,) ,
                SizedBox(
                  width: 350.w,
                  child: AutoSizeText(
                    '''votre commande arrive
                                beintot.''',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      //  fontWeight: FontWeight.bold ,
                    ),
                  ),
                ),
                SizedBox(
                  height: 171.h,
                ),
                SizedBox(
                  width: 200.w,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Classe1.classe=Home();
                      Main_Page.currentindex=0;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Main_Page()));
                    },
                    child: AutoSizeText(
                      "Acceuil",
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
