import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:clientapp/database/restdata.dart';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Click_restaurant.dart';
import 'Favoris.dart';
import 'Home.dart';
import 'Panier.dart';
import 'Profile.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List interfaces = [Home() , Panier() , Favoris()  ,Profile() ];
  List<Restaurant> restaurant = [

  ];
  var controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
          Column(
            children: [
              SizedBox(height: 0.h,) ,
              AutoSizeText('Restaurant' , style: TextStyle(
                fontSize: 25.sp,
                color: Colors.black,
                fontFamily: 'regular',

              ),),
              //SizedBox(height: 10.h,) ,
            ],
          ) ,
          leading: TextButton(
            onPressed: (){
                Navigator.pop(
                context);},
            child:Icon(Icons.arrow_back,size: 28.sp,color: Colors.black,),

          ),
          backgroundColor: Colors.transparent,
          shadowColor:  Colors.transparent,
          foregroundColor:Colors.black ,
        ),
        body: StreamBuilder<List<Restaurant>>(
          stream: RestauService().restaurantList,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              restaurant=snapshot.data!;
            }
            return Column(
              children: [
                SizedBox(height: 10.h),
                Expanded(
                  child: Scrollbar(
                    showTrackOnHover: true,
                    radius: Radius.circular(50.sp),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: restaurant.length,
                        itemBuilder: (context, index) {
                          final url = restaurant[index].imageUrl;
                          final nom = restaurant[index].nom;
                          return Container(
                              height: 170.h,
                              width: 330.w,
                              child: Column(

                                children: [
                                  SizedBox(height: 30.h,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 15.w),
                                        Container(
                                          height: 100.h,
                                          width: 140.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20.sp),
                                            image: DecorationImage(
                                                image: NetworkImage(url),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 37.h,
                                                width: 142.h,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffffda82),
                                                      width: 1.w,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                  BorderRadius.circular(18.sp),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    ' $nom ',
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      color: Colors.black,
                                                      fontFamily: 'thin',
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 29.h,
                                            ),
                                            Container(
                                                height: 25.h,
                                                width: 84.h,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Classe1.classe= Click_restaurant(restaurant_id: restaurant[index].id,image: url,name: nom, );
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Main_Page()));
                                                    },
                                                    child: FittedBox(
                                                      child: AutoSizeText(
                                                        'Découvrir',

                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: Colors.white,
                                                          fontFamily: 'regular',
                                                        ),
                                                      ),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Color(0xffF54749),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                        )))),
                                          ],
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  Container(
                                    height: 1.h,
                                    width: 315.w,
                                    child: Divider(
                                      thickness: 2.w,
                                      color: Color(0xffF54749),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  )
                                ],
                              ));
                        }),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
