import 'package:clientapp/classe1.dart';
import 'package:clientapp/client/panier.dart';
import 'package:clientapp/database/database.dart';
import 'package:clientapp/database/restdata.dart';
import 'pageRestau.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'Complet_Order.dart';
import 'Page.dart';
import 'auth/user.dart';

class PanierPleine extends StatefulWidget {
  PanierPleine({
    Key? key,
  });
  @override
  State<PanierPleine> createState() => _PanierPleineState();
}

class _PanierPleineState extends State<PanierPleine> {
  List<Panier> plat = [];
  bool is_deleted = false;

  ScrollController controller = ScrollController();

  bool isPressed = false;
  double prixtotal = 0;

  double total = 0;

  int counter = 0;

  bool getInitial() {
    return isPressed;
  }

  @override
  void initState() {
    super.initState();
  }

  double height = 0;

  getImage(Panier plat) {
    RestauService().getplatImage(plat.categore);
    RestauService().getfoodImage(plat.categore);
  }

  @override
  Widget build(BuildContext context) {
    // total = prixinitiale();

    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<List<Panier>>(
        stream: DatabaseService(uid: user!.uid).panier,
        builder: (context, snapshot) {
          String foodImage = "";
          String platImage = "";
          if (snapshot.hasData) {
            plat = snapshot.data!;
            DatabaseService.list = snapshot.data;
            //    prixtotal=0;

          }
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  AutoSizeText(
                    'Votre Commande',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontFamily: 'regular',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  Classe1.classe = Accueil();
                  Main_Page.currentindex = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Main_Page()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 28.sp,
                  color: Colors.black,
                ),
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Scrollbar(
                    showTrackOnHover: true,
                    radius: Radius.circular(50.sp),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        itemCount: plat == null ? 0 : plat.length,
                        itemBuilder: (BuildContext context, int index) {
                          getImage(plat[index]);
                          foodImage = RestauService.foodImage;
                          platImage = RestauService.plasImage;
                          double prix = double.parse("${plat[index].prix}");

                          prixtotal = prixtotal + plat[index].prix;
                          String cnt;
                          "${plat[index].quantite}".length == 1
                              ? cnt = "${plat[index].quantite}".substring(0, 1)
                              : cnt = "${plat[index].quantite}".substring(0, 2);
                          int counter = int.parse(cnt);
                          print(foodImage);
                          return Column(
                            children: [
                              Dismissible(
                                key: Key('${plat[index]}'),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      foodImage ==
                                                              'images/burger.png'
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: 110.h,
                                                                  width: 110.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          platImage),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          15.h,
                                                                      horizontal:
                                                                          2.w),
                                                                  height: 80.h,
                                                                  width: 100.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          foodImage),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : foodImage ==
                                                                  'images/pizza.png'
                                                              ? Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          100.h,
                                                                      width:
                                                                          110.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(platImage),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical: 6
                                                                              .h,
                                                                          horizontal:
                                                                              0.5.w),
                                                                      height:
                                                                          90.h,
                                                                      width:
                                                                          105.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              AssetImage(foodImage),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : foodImage ==
                                                                      'Plats'
                                                                  ? Stack(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              100.h,
                                                                          width:
                                                                              100.w,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage(platImage), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.symmetric(
                                                                              vertical: 25.h,
                                                                              horizontal: 5.w),
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              55.w,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage(foodImage), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.symmetric(
                                                                              vertical: 18.h,
                                                                              horizontal: 27.w),
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              55.w,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage(foodImage), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : foodImage ==
                                                                          'images/tacos.png'
                                                                      ? Stack(
                                                                          children: [
                                                                            Container(
                                                                              height: 100.h,
                                                                              width: 100.w,
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(image: AssetImage(platImage), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.w),
                                                                              height: 85.h,
                                                                              width: 90.w,
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(image: AssetImage(foodImage), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              110.h,
                                                                          width:
                                                                              110.w,
                                                                        ),

                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Container(
                                                        height: 40.h,
                                                        width: 190.w,
                                                        child: Center(
                                                          child: AutoSizeText(
                                                            ' ${plat[index].nom} ',
                                                            style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xbfffda82),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.r),
                                                        ),
                                                      ),
                                                      //SizedBox(width: 10.w,) ,
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          AutoSizeText(
                                                            '${prix}0 DA',
                                                            style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 70.w,
                                                          ),
                                                          SizedBox.fromSize(
                                                            size:
                                                                Size.fromRadius(
                                                                    15),
                                                            child:
                                                                FloatingActionButton(
                                                              heroTag: "mino",
                                                              onPressed: () {
                                                                {
                                                                  setState(() {
                                                                    counter-- >
                                                                            0
                                                                        ? prixtotal =
                                                                            prixtotal -
                                                                                prix
                                                                        : prixtotal =
                                                                            prixtotal;
                                                                    counter-- <=
                                                                            0
                                                                        ? counter++
                                                                        : print(
                                                                            '');
                                                                    /*   counter > 1 ? counter -- : print(
                                                                          'bzf eelik'); */
                                                                    DatabaseService(uid: user.uid).UpdatePlatMoin(plat[index]
                                                                            .resId +
                                                                        "" +
                                                                        plat[index]
                                                                            .id);
                                                                  });
                                                                }
                                                              },
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: Color(
                                                                      0xffF54749)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.r),
                                                              ),
                                                            ),
                                                          ),
                                                          AutoSizeText(
                                                            counter < 10
                                                                ? " 0$counter "
                                                                : " $counter ",
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                fontFamily:
                                                                    'Poppins'),
                                                          ),
                                                          SizedBox.fromSize(
                                                            size:
                                                                Size.fromRadius(
                                                                    15),
                                                            child:
                                                                FloatingActionButton(
                                                              heroTag: "plus",
                                                              onPressed: () {
                                                                {
                                                                  setState(() {
                                                                    counter < 30
                                                                        ? prixtotal =
                                                                            prixtotal +
                                                                                prix
                                                                        : prixtotal =
                                                                            prixtotal;
                                                                    counter < 30
                                                                        ? counter++
                                                                        : print(
                                                                            'bzf eelik');

                                                                    DatabaseService(uid: user.uid).UpdatePlatPlus(plat[index]
                                                                            .resId +
                                                                        "" +
                                                                        plat[index]
                                                                            .id);
                                                                  });
                                                                }
                                                              },
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xffF54749)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.r),
                                                              ),
                                                            ),
                                                          ),
                                                          //  SizedBox(width : 15.w)
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 9.w)
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xffC4C4C4),
                                              width: 2.5.w,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(7.r),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15.h,
                                    ),
                                  ],
                                ),
                                onDismissed: (direction) {
                                  DatabaseService(uid: user.uid)
                                      .deletePanier(plat[index]);
                                },
                              ),
                              index == plat.length - 1
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Container(
                                          width: 330.w,
                                          height: 200.h,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  Expanded(
                                                    child: AutoSizeText(
                                                        '+500.00 DA de livraison',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color:
                                                              Color(0xffF54749),
                                                          fontFamily: 'Poppins',
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  AutoSizeText('Prix Total :',
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                      )),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 170.w,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              blurRadius: 7,
                                                              spreadRadius: 2,
                                                              offset:
                                                                  Offset(3, 5))
                                                        ],
                                                        border: Border.all(
                                                          color:
                                                              Color(0xffF54749),
                                                          width: 2.5.w,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r),
                                                      ),
                                                      child: Center(
                                                        child: AutoSizeText(
                                                            '${Prix(plat)}',
                                                            style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Poppins',
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                              SizedBox(
                                                width: 160.w,
                                                height: 55.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Complet_Order()));
                                                  },
                                                  child: AutoSizeText(
                                                    'Suivant',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shadowColor:
                                                              Colors.grey,
                                                          primary:
                                                              Color(0xffF54749),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          )),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ));
        });
  }

  Prix(List<Panier> plat) {
    double prix = 0;
    for (int i = 0; i < plat.length; i++) {
      prix += plat[i].prix.toDouble() * plat[i].quantite.toDouble();
    }
    return prix;
  }
}
