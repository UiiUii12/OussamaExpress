import 'package:clientapp/wrapper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription subscription;
  late ConnectivityResult result;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen(navigate);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Color(0xffFEE4E4),);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFEE4E4),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) * (1 / 4),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/logo1.png'
                    )
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SpinKitSpinningLines(
              size: 50.sp,
              color: Color(0xffF54749),
            )
          ],
        ),
      ),
    );
  }
  void navigate(ConnectivityResult result) {
    result != ConnectivityResult.none
        ? Timer(
        Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper())))
        : Container();
  }
}