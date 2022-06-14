import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/client/panier.dart';
import 'package:clientapp/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import 'Commande_arrive-bientot.dart';
import 'auth/user.dart';

class Adress extends StatefulWidget {
  const Adress({Key? key}) : super(key: key);

  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  String adress="";
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return
      SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                SizedBox(height: 20.h,) ,
                SizedBox(
                  width: 300.w,
                  child: AutoSizeText('''Insertion d'une addresse''',
                    textAlign: TextAlign.center,
                    // minFontSize: 22.sp,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline ,

                    ),),
                ) ,
                SizedBox(height: 70.h,) ,
                SizedBox(
                  width: 350.w,
                  child: AutoSizeText('''Veuillez insérer l'adresse où vous souhaitez recevoir votre commande de google map.''' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',

                    ),),
                ) ,
                SizedBox(height: 50.h,) ,
                Container(
                  height:  60,
                  width: 350,
                  child: Center(
                    child: TextFormField(
                      onChanged: (value){
                        adress=value;
                      },
                      decoration: InputDecoration(

                        counterText: '',
                        contentPadding: EdgeInsets.all(10.0.h),
                        border: InputBorder.none,
                        hintText: 'Inséreez ici ...',
                        hintStyle: TextStyle(
                            color: Color(0xffa7a7a7),
                            fontSize: 14.sp,
                            fontFamily: 'poppins'),
                        filled: true,
                        fillColor: Colors.transparent,
                        isCollapsed: true,
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xffF54749),
                      width: 2.5.w,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ) ,
                SizedBox(height: 150.h,) ,
                SizedBox(
                  width: 200.w,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      List<Location> locations = await locationFromAddress(adress);

                      List<Panier>? list=DatabaseService.list;

                     await DatabaseService(uid: user!.uid).writeCommande(locations[0]);

                     for(int i =0;i<list!.length;i++){
                      await DatabaseService(uid: user.uid).deletePanier(list[i]);
                      await DatabaseService(uid: user.uid).UpdatePanierMoin();}

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CommandeariveBeintot()));
                    },
                    child: AutoSizeText(
                      "C'est Fini",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey,
                        primary: Color(0xffffda82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
  }
}
