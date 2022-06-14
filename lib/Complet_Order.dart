import 'dart:async';
import 'package:clientapp/database/database.dart';
import 'package:geocoding/geocoding.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'Commande_arrive-bientot.dart';
import 'adress.dart';
import 'auth/user.dart';
import 'client/panier.dart';

class Complet_Order extends StatefulWidget {
  Complet_Order({Key? key}) : super(key: key);

  @override
  State<Complet_Order> createState() => _Complet_OrderState();
}
double long = 0, lat = 0;
class _Complet_OrderState extends State<Complet_Order> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;


  late StreamSubscription<Position> positionStream;
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

DatabaseService.long=position.longitude;
DatabaseService.lat=position.latitude;
    long = position.longitude;
    lat = position.latitude;

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457
      DatabaseService.long=position.longitude;
      DatabaseService.lat=position.latitude;
      long = position.longitude;
      lat = position.latitude;

      setState(() {
        //refresh UI on update
      });
    });
  }
  getLocation2() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude;
    lat = position.latitude;



    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude;
      lat = position.latitude;


    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(DatabaseService.list);
    return
      SafeArea(child: Scaffold(
        body: Column(
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
            SizedBox(height: 40.h,) ,
            Container(
              height: 200.h,
              width: 300.w,
              margin: EdgeInsets.symmetric(horizontal: 57.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Location.png"),
                ),
              ),
            ),
            SizedBox(height: 50.h,) ,
            SizedBox(
              width: 350.w,
              child: AutoSizeText(
                '''Veuillez activer votre location pour continuer.''',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  //  fontWeight: FontWeight.bold ,
                ),
              ),
            ),
            SizedBox(
              height: 81.h,
            ),
            SizedBox(
              width: 220.w,
              height: 70.h,
              child: ElevatedButton(

                onPressed: () async {
                  var dt = DateTime.now();
                  await checkGps();
                  Location location;

                print(lat);
                print("hawliv");
                print(DatabaseService.lat);
                  location=Location(latitude: DatabaseService.lat!, longitude: DatabaseService.long!, timestamp:dt);
                 List<Panier>? list=DatabaseService.list;

                   await DatabaseService(uid: user!.uid).writeCommande(location);

                        for(int i =0;i<list!.length;i++){
                        await  DatabaseService(uid: user.uid).deletePanier(list[i]);
                        await DatabaseService(uid: user.uid).UpdatePanierMoin();}

                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                            CommandeariveBeintot()));
                                },


                child: AutoSizeText(
                  'Activer Location',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
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
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: 220.w,
              height: 70.h,
              child: ElevatedButton(

                onPressed: ()  {


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Adress()));},
                child: AutoSizeText(
                  'Insérer une adresse',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
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
      ));
  }
}
