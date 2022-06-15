import 'package:auto_size_text/auto_size_text.dart';

import 'package:clientapp/categorie.dart';

import 'package:clientapp/database/restdata.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Home.dart';
import 'Page.dart';
import 'classe1.dart';

class Click_restaurant extends StatefulWidget {
  final restaurant_id, image, name;
  const Click_restaurant(
      {Key? key,
      required this.restaurant_id,
      required this.image,
      required this.name})
      : super(key: key);

  @override
  State<Click_restaurant> createState() => _Click_restaurantState();
}

class _Click_restaurantState extends State<Click_restaurant> {
  List<String> tableau = [];
  String nom = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: RestauService().tabcate(widget.restaurant_id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            tableau = snapshot.data!;
          }
          return DefaultTabController(
            length: tableau.length,
            child: SafeArea(
                child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Classe1.classe = Home();

                          Main_Page.currentindex = 0;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Main_Page()));
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
                      SizedBox(
                        width: 93.55.w,
                      ),
                      Expanded(
                        child: Stack(children: [
                          ClipPath(
                            clipper: Clipper(),
                            child: Container(
                              height: 205.h,
                              width: 225.w,
                              color: Color(0xffF54749),
                            ),
                          ),
                          ClipPath(
                            clipper: Clipper(),
                            child: Container(
                              height: 190.h,
                              width: 225.w,
                              child: Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 25.w,
                      ),
                      Container(
                          height: 40.h,
                          width: 152.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF54749),
                                width: 1.w,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  color: Colors.black,
                                  fontFamily: 'thin',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Color(0xffffda82),
                      unselectedLabelStyle: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: 'ines',
                          fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.bold),
                      unselectedLabelColor: Color(0xffF54749),
                      indicatorColor: Color(0xffffda82),
                      indicatorWeight: 3.w,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        for (var v in tableau)
                          Tab(
                            text: '$v',
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      for (var i in tableau)
                        Catego(
                          restaurant_id: widget.restaurant_id,
                          categorie: i,
                          name: widget.name,
                          image: widget.image,
                        ),
                    ]),
                  )
                ],
              ),
            )),
          );
        });
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, 00);
    var controllPoint = Offset(00, size.height);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
