import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Login.dart';
import 'package:clientapp/Model/slide.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/Widgets/SlideItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import '../widgets/slidedots.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth/auth.dart';

class OnBoarding extends StatefulWidget {
  @override
  _onBoarding createState() => _onBoarding();
}

class _onBoarding extends State<OnBoarding> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 500), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
          duration: Duration(seconds: 150), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
      Colors.white,);
    return SafeArea(
        child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/BG.png'),
            fit: BoxFit.cover,
          )),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Stack(
                  alignment: Alignment(0, 1.1),
                  children: <Widget>[
                    PageView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                         // margin: EdgeInsets.only(bottom: 40.h),
                          child: Row(
                            //mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: SizedBox(
                         width: 200.w,
                         height: 60.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: AutoSizeText(
                            'Connectez-vous',
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
                                borderRadius: BorderRadius.circular(10.r),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    Container(
                      width: 110.w,
                      height: 50.h,
                      child: OutlinedButton(
                        child: AutoSizeText(
                          "Découvrir",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Color(0xffffda82),
                              width: 3.w,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r))),
                        onPressed: () async{
                          await AuthService().signeInAnon();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Main_Page()));
                        },
                      ),
                    ),
                    SizedBox(height: 70.h,)
                  ],
                )
              ],
            ),
          ),
         )
        ],
      )
    );
  }
}
