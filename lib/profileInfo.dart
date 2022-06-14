import 'package:clientapp/auth/auth.dart';
import 'package:clientapp/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'auth/user.dart';

class Profile_Infos extends StatefulWidget {
  const Profile_Infos({Key? key}) : super(key: key);

  @override
  State<Profile_Infos> createState() => _Profile_InfosState();
}

class _Profile_InfosState extends State<Profile_Infos> {
  var modifier = false;

  String name = '';

  TextEditingController value = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<String>(
      stream:DatabaseService(uid: user!.uid).Lenom ,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          name=snapshot.data!;
        }
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    height: 800.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/BG.png"), fit: BoxFit.cover),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 30),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_back,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                          )),
                      Container(
                        height: 200.h,
                        width: 300.w,
                        margin: EdgeInsets.symmetric(horizontal: 57.w),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/Profile.png"),
                          ),
                        ),
                      ),
                      Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          //  fontWeight: FontWeight.bold ,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        height: 62.h,
                        width: 287.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                                title: modifier == false
                                    ? Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    // fontWeight: FontWeight.bold ,
                                  ),
                                )
                                    : Container(
                                  height: 48.h,
                                  width: 100.w,
                                  child: Center(
                                    child:
                                    TextFormField(
                                      enabled: true,
                                      controller: value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Entrer votre nom',
                                        hintStyle: TextStyle(
                                            color: Color(0xffa7a7a7),
                                            fontSize: 13.sp,
                                            fontFamily: 'poppins'),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        isCollapsed: true,
                                      ),
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ),
                                leading: Icon(MdiIcons.account),
                                trailing: modifier == false
                                    ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        modifier = true;
                                      });
                                    },
                                    icon: Icon(MdiIcons.pencil))
                                    : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        DatabaseService(uid: user.uid).changenom(value.text);
                                        modifier = false;
                                      });
                                    },
                                    icon: Icon(MdiIcons.check))),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF54749),
                                width: 2.5.w,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12.sp)),
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      Container(
                        height: 62.h,
                        width: 287.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(
                                user.phone!,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  //  fontWeight: FontWeight.bold ,
                                ),
                              ),
                              leading: Icon(MdiIcons.phone),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF54749),
                                width: 2.5.w,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12.sp)),
                      ),
                      SizedBox(
                        height: 76.h,
                      ),
                      SizedBox(
                        width: 225.w,
                        height: 55.h,
                        child: ElevatedButton(
                          onPressed: () {
                            AuthService().singeOut();
                          },
                          child: Text(
                            'Se déconnecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.grey,
                              primary: Color(0xffF54749),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
