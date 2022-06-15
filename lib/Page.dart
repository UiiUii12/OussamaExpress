import 'package:clientapp/chackUser1.dart';
import 'package:clientapp/classe2.dart';
import 'package:clientapp/wrappers/favorisW.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clientapp/my_flutter_app_icons.dart';

import 'classe1.dart';

class Main_Page extends StatefulWidget {
  Main_Page({Key? key}) : super(key: key);
  static int currentindex = 0;
  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  List interfaces = [Classe1(), Classe2(), FavorisW(), Wrapper2()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: interfaces[Main_Page.currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            Main_Page.currentindex = index;
          });
        },
        currentIndex: Main_Page.currentindex,
        selectedItemColor: Color(0xfff54749).withOpacity(0.7),
        unselectedItemColor: Colors.black,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.cart), label: 'Panier'),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.heart),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                MyFlutterApp.user,
              ),
              label: 'Profil'),
        ],
      ),
    ));
  }
}
