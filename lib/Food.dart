import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Click_restaurant.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:clientapp/classe2.dart';
import 'package:clientapp/my_flutter_app_icons.dart';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:clientapp/wrappers/panierW.dart';
import 'package:flutter/cupertino.dart';
import 'package:clientapp/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'auth/user.dart';
import 'database/database.dart';
import 'database/restdata.dart';



class Food extends StatefulWidget {
  final Plat plat;
  final   restaurant ;
  final image ;
  final name ;
  const Food( {Key? key,required this.plat,this.restaurant, this.image, this.name}) : super(key: key);
  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  String text="";
  String foodImage="";
  String platImage="";
  bool value=DatabaseService.exist;
  bool isPressed = false;
  int _counter = 1;
  num prixUnitaire = 250;
  var foodName = '';
  var description = '';
  int o=0;

  num prixTotal(num prixUnitaire) {
    return prixUnitaire * _counter;
  }

  void _incrementCounter() {
    setState(() {
      _counter < 30 ? _counter++ : print('bzf eelik');
    });
  }

  bool getInitial() {

    return isPressed;
  }

  void _decrementCounter() {
    setState(() {
      _counter > 1 ? _counter-- : print('bzf eelik');
    });
  }
  getImage(){
    RestauService().getplatImage(widget.plat.categore) ;
   RestauService().getfoodImage(widget.plat.categore);
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
if(o==0) {
  isPressed = DatabaseService.exist;
}
    foodName=widget.plat.nom;
    prixUnitaire=widget.plat.prix;
    description=widget.plat.descreption;
    setState(() {
      getImage();
      foodImage= RestauService.foodImage;
      platImage=RestauService.plasImage;
      print(foodImage);
    });
;



    return SafeArea(
        child: Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Classe1.classe= Click_restaurant(restaurant_id: widget.restaurant, image: widget.image, name: widget.name,);
                Main_Page.currentindex=0 ;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Main_Page() ));
                            },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
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
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 130.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState((){
                          if (isPressed == false) {
                            //isPressed = getInitial();
                            DatabaseService(uid: user!.uid).updateFavoris(widget.plat);
                            isPressed = true;
                            o++;

                           DatabaseService(uid: user.uid).UpdateFavorisPlus();
                          } else{
                            DatabaseService(uid: user!.uid).deletFavoris(widget.plat);
                            isPressed = false;
                            o++;

                           DatabaseService(uid: user.uid).UpdateFavorisMoin();
                        }});
                      },
                      child: Icon(
                        isPressed
                            ? MyFlutterApp.heart_1
                            : MyFlutterApp.heart_empty,
                        size: 30.sp,
                        color: Color(0xffF54749),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      width: 170.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF54749),
                          width: 1.5.w,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: AutoSizeText(
                          "$prixUnitaire.00 DA",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            fontFamily: 'Poppins',
                            // fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    foodImage == 'images/burger.png' ?
                    Stack(
                      children: [
                        Container(
                          height: 120.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(platImage),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal:6.w),
                          height: 80.h,
                          width: 90.w,
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
                              vertical: 6.h, horizontal: 0.5.w),
                          height: 100.h,
                          width: 105.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(foodImage),
                            ),
                          ),
                        ),
                      ],
                    ) : foodImage =='images/chicken.png' ?
                    Stack(
                      children: [
                        Container(
                          height: 110.h,
                          width: 110.w,
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
                          height: 110.h,
                          width: 111.5.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(platImage),
                                fit: BoxFit.cover
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 0.h, horizontal: 5.w),
                          height: 90.h,
                          width: 100.w,
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
                          height: 150.h,
                          width: 135.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(platImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 25.h, horizontal: 8.w),
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(foodImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ), */
                    SizedBox(
                      width: 0.w,
                    ),
                    Container(
                      //                    height: 90,
                      width: 210.w,
                      constraints: const BoxConstraints(
                        minHeight: 90,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFFDA82).withOpacity(0.75),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: AutoSizeText(
                              '$foodName',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: AutoSizeText(
                              description,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //width: 300,
                      //height: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffFFDA82),
                          width: 2.5.w,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                height: 41.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: AutoSizeText(
                                  'Quantité :',
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              SizedBox.fromSize(
                                size: Size.fromRadius(15),
                                child: FloatingActionButton(
                                  heroTag: "bottom1",
                                  onPressed: _decrementCounter,
                                  child:
                                      Icon(Icons.remove, color: Color(0xffF54749)),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),
                              AutoSizeText(
                                _counter < 10
                                    ? " 0${_counter.toString()} "
                                    : " ${_counter.toString()} ",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              ),
                              SizedBox.fromSize(
                                size: Size.fromRadius(15),
                                child: FloatingActionButton(
                                  heroTag: "bottom two",
                                  onPressed: _incrementCounter,
                                  child: Icon(Icons.add, color: Color(0xffF54749)),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                height: 41.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: AutoSizeText(
                                  'Prix total :',
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Container(
                                width: 108.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  color: Color(0xffC4C4C4).withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(17.sp),
                                ),
                                child: AutoSizeText(
                                    ' ${prixTotal(prixUnitaire).toString()}.00 DA ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23.sp,
                                      color: Colors.black,
                                    )),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                height: 41.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: AutoSizeText('Additionnel :',
                                    style: TextStyle(
                                      fontSize: 27.sp,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(
                                width: 35.w,
                              ),
                              Row(children: [buildSwitch()]),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          value
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        messageBox(),
                                        SizedBox(width: 30.w),
                                      ],
                                    ),
                                    SizedBox(height: 30)
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 60.h,
            ),
            SizedBox(
              width: 200.w,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Classe2.classe=PanierW();
                  Classe1.classe=Home();
                  Main_Page.currentindex=1;

                  DatabaseService(uid: user!.uid).updatePanier(widget.plat, _counter, text);
                  DatabaseService(uid: user.uid).UpdatePanierPlus();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Main_Page()));

                },
                child: AutoSizeText(
                  'Ajouter au panier',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    //textStyle: TextStyle(color: Colors.white),
                    shadowColor: Colors.grey,
                    primary: Color(0xffF54749),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1,
        child: CupertinoSwitch(
            activeColor: Color(0xffFFDA82),
            value: value,
            onChanged: (value) => setState(() => this.value = value)),
      );
  Widget messageBox() {
    return Center(
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 260.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.w,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextFormField(
              onChanged: (value){
                text=value;
              },
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              maxLength: 200,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.all(10.0.h),
                border: InputBorder.none,
                hintText:'Insérer votre message',
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Poppins',
                  color: Colors.grey[500],
                ),
                isCollapsed: true,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}
