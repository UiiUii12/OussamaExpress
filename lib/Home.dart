import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/Search.dart';
import 'package:clientapp/classe1.dart';
import 'package:clientapp/database/database.dart';
import 'package:clientapp/database/restdata.dart';
import 'package:clientapp/pageRestau.dart';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:clientapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'auth/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String User = '';
  int activeIndex = 0;
  int activeIndex2 = 0;
  String texet = "";
  var Urlimages = [
    'https://firebasestorage.googleapis.com/v0/b/projet-8522f.appspot.com/o/Promotion%2Foussss.png?alt=media&token=ae9f7052-0571-45be-ba73-57d3ad787e8f',
  ];
  var UrlRestaurants = [];

  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Wrapper()));
    }
    User = DatabaseService(uid: user!.uid).gatNom();
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(children: [
        Column(
          children: [
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        AutoSizeText(
                          'Bienvenue,',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        AutoSizeText(
                          '@$User',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    StreamBuilder<List<Restaurant>>(
                        stream: RestauService().restaurantList,
                        builder: (context, snapshot) {
                          List<Restaurant> list = [];
                          if (snapshot.hasData) {
                            list = snapshot.data!;
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 330.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Color(0xffF54749),
                                    width: 1.5.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    texet = value;
                                  },
                                  onTap: () {
                                    List<Restaurant> l = sugestion(list, texet);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Search(list: l)));
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Color(0xffF54749),
                                    ),
                                    contentPadding: EdgeInsets.all(10.0.h),
                                    border: InputBorder.none,
                                    hintText: 'Recherche...',
                                    hintStyle: TextStyle(
                                      color: Color(0xffa7a7a7),
                                      fontSize: 13.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    isCollapsed: true,
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: StreamBuilder<List<String>>(
                  stream: RestauService().promotion,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Urlimages.add(
                          "https://firebasestorage.googleapis.com/v0/b/projet-8522f.appspot.com/o/Promotion%2Foussss.png?alt=media&token=ae9f7052-0571-45be-ba73-57d3ad787e8f");
                      Urlimages = snapshot.data!;
                    }
                    return Column(
                      children: [
                        CarouselSlider.builder(
                            itemCount: Urlimages.length,
                            itemBuilder: (context, index, realIndex) {
                              print(Urlimages);
                              String urlImage = Urlimages[index];
                              return buildImage(urlImage, index);
                            },
                            options: CarouselOptions(
                                height: 160.h,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 4),
                                enlargeCenterPage: true,
                                pageSnapping: false,
                                onPageChanged: (index, reason) =>
                                    setState(() => activeIndex = index))),
                        SizedBox(
                          height: 20.h,
                        ),
                        buildIndicator(),
                      ],
                    );
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        StreamBuilder<List<String>>(
            stream: RestauService().sugestion,
            builder: (context, snapshot) {
              int nombre = 0;
              if (snapshot.hasData) {
                UrlRestaurants = snapshot.data!;
                nombre = UrlRestaurants.length;
                if (nombre > 5) {
                  nombre = 5;
                }
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      AutoSizeText(
                        'Restaurant :',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'ines',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                          height: 150.h,
                          width: 350.w,
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: nombre,
                              separatorBuilder: (context, _) => SizedBox(
                                    width: 0.w,
                                  ),
                              itemBuilder: (context, index) =>
                                  buildRestaurant(UrlRestaurants[index]))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Classe1.classe = Accueil();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Main_Page()));
                        },
                        child: AutoSizeText(
                          "Afficher plus",
                          style: TextStyle(
                            color: Colors.black,
                            //  fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 15.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  )
                ],
              );
            }),
      ]),
    )));
  }

  Widget buildImage(String Urlimage, int index) {
    return Container(
      //height:40.h,
      //width: 340.w,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
            image: NetworkImage(Urlimage),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget buildRestaurant(String urlRestaurant) => Row(
        children: [
          SizedBox(
            width: 10.h,
          ),
          Container(
            width: 200.w,
            //margin: EdgeInsets.symmetric(horizontal: .w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  image: NetworkImage(urlRestaurant),
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: Urlimages.length,
        effect: ExpandingDotsEffect(
          dotWidth: 12.h,
          dotHeight: 9.h,
          activeDotColor: Color(0xffFEE199),
          dotColor: Color(0xffCCCCCC),
        ),
      );
  List<Restaurant> sugestion(List<Restaurant> list, String s) {
    List<Restaurant> l = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].nom.contains(s)) {
        l.add(list[i]);
      }
    }
    return l;
  }
}
