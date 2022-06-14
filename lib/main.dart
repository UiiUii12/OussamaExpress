import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clientapp/splashScreen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'auth/auth.dart';
import 'auth/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent ,
    statusBarIconBrightness: Brightness.dark ,
    statusBarBrightness: Brightness.dark ,
    systemNavigationBarColor: Colors.transparent ,
    systemNavigationBarIconBrightness: Brightness.dark ,
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;
  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen(showToast);
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return StreamProvider<MyUser?>.value(
      value:AuthService().user,
      initialData: null,
      catchError: (e,i) => null,
      child: ScreenUtilInit(
        designSize: Size(360,800),
        minTextAdapt: true,
        splitScreenMode: true,

        builder:(BuildContext,context )  => OverlaySupport.global(
          child: MaterialApp(
              /*  theme: ThemeData(
               appBarTheme: AppBarTheme(
                 brightness: Brightness.dark,
                 systemOverlayStyle: SystemUiOverlayStyle.dark, //

             ),),*/
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          )
        ),
      ),
    );
  }
  void showToast(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    String Message = hasInternet ? 'Connecté' : 'Non connecté';
    Fluttertoast.showToast(
      msg: Message,
      fontSize: 15.sp,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }
}




