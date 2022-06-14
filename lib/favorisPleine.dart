import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/database/database.dart';
import 'package:clientapp/database/restdata.dart';
import 'package:clientapp/my_flutter_app_icons.dart';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Food.dart';
import 'auth/user.dart';

class FavorisPleine extends StatefulWidget {

  const FavorisPleine({Key? key,}) : super(key: key);

  @override
  State<FavorisPleine> createState() => _FavorisPleineState();
}

class _FavorisPleineState extends State<FavorisPleine> {
  getImage(Plat plat){
    RestauService().getplatImage(plat.categore) ;
    RestauService().getfoodImage(plat.categore);
  }

  @override
  Widget build(BuildContext context) {

    List<Plat> plat= [];
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<List<Plat>>(
      stream: DatabaseService(uid: user!.uid).favoris,

      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData){
          plat=snapshot.data!;

        }
        return SafeArea(child: Scaffold(
          appBar: AppBar(
            title:
            Column(
              children: [
                SizedBox(height: 15.h,) ,
                AutoSizeText('Favoris' , style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontFamily: 'Poppins',

                ),),
                SizedBox(height: 15.h,) ,
              ],
            ) ,
            leading: Icon(
              Icons.arrow_back,
              size: 28.sp,
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent,
            shadowColor:  Colors.transparent,
            foregroundColor:Colors.black ,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: plat.length,
                    itemBuilder: (BuildContext context, int index) {

                      getImage(plat[index]);
                      String platImage=RestauService.plasImage;
                      String foodImage=RestauService.foodImage;
                      final String nom = '${plat[index].nom}';
                      final String prix =  '${plat[index].prix}.00';
                      return GestureDetector(
                        onTap: () {

                          DatabaseService.exist=true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>Food(plat: plat[index])));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Container(
                                              height: 100.h,
                                              width: 325.w,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffffda82),
                                                  borderRadius:
                                                  BorderRadius.circular(15.sp),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 7,
                                                        spreadRadius: 2,
                                                        offset: Offset(3, 5))
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 97.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Container(
                                                          height: 35.h,
                                                          width: 198.h,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            Colors.transparent,
                                                            border: Border.all(
                                                                color: Colors.white,
                                                                width: 1.w,
                                                                style: BorderStyle
                                                                    .solid),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.sp),
                                                          ),
                                                          child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              ' $nom ',
                                                              style: TextStyle(
                                                                fontSize: 22.sp,
                                                                color: Color(
                                                                    0xffF54749),
                                                                fontFamily:
                                                                'Poppins',
                                                                //fontWeight: FontWeight.bold ,
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 23.h,
                                                            width: 99.w,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20.sp),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors.grey
                                                                          .withOpacity(
                                                                          0.5),
                                                                      blurRadius: 7,
                                                                      spreadRadius: 2,
                                                                      offset:
                                                                      Offset(3, 5))
                                                                ]),
                                                            child: FittedBox(
                                                              child: Text(
                                                                '$prix' + ' DA',
                                                                style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  color:
                                                                  Color(0xffF54749),
                                                                  fontFamily: 'Poppins',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 60.w,) ,
                                                          Icon(MyFlutterApp.heart_1 ,
                                                            color: Color(0xffF54749),
                                                            size: 20.sp,)
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                      foodImage == 'images/burger.png' ?
                      Stack(
                      children: [
                      Container(
                      height: 110.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(platImage),
                      ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(
                      vertical: 15.h, horizontal: 2.w),
                      height: 80.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(foodImage),
                      ),
                      ),
                      ),
                      ],
                      ) : foodImage== 'images/pizza.png' ?
                      Stack(
                      children: [
                      Container(
                      height: 100.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(platImage),
                      ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(
                      vertical: 6.h, horizontal: 0.5.w),
                      height: 90.h,
                      width: 105.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(foodImage),
                      ),
                      ),
                      ),
                      ],
                      ) : foodImage =='Plats' ?
                      Stack(
                      children: [
                      Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(platImage),
                      fit: BoxFit.cover
                      ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(
                      vertical: 25.h, horizontal: 5.w),
                      height: 50.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(foodImage),
                      fit: BoxFit.cover
                      ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(vertical: 18.h, horizontal: 27.w),
                      height: 50.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(foodImage),
                      fit: BoxFit.cover
                      ),
                      ),
                      ),
                      ],
                      ) : foodImage == 'images/tacos.png' ?
                      Stack(
                      children: [
                      Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(platImage),
                      fit: BoxFit.cover
                      ),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(
                      vertical: 0.h, horizontal: 6.w),
                      height: 85.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage(foodImage),
                      fit: BoxFit.cover
                      ),
                      ),
                      ),
                      ],
                      ) : Container(height: 110.h, width: 110.w,) ,

                      /*      Stack(
                                  children: [
                                    Container(
                                      height: 100.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(plaImage),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 6.h, horizontal: 0.5.w),
                                      height: 90.h,
                                      width: 105.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:AssetImage(foodImage),
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                            ]),*/
                            SizedBox(height: 15.h,)
                          ],
                        ),
                   ])   );
                    }),
              ),
            ],
          ),
        ));
      }
    );
  }
}
