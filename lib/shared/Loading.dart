import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  static  bool  loading =false ;
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitFadingCircle(
          color: Color(0xffF54749),
          size:70.sp,
        ),
      ),
    );
  }
}
