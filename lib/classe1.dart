import 'package:clientapp/Home.dart';

import 'package:flutter/cupertino.dart';



class Classe1 extends StatelessWidget {
  Classe1({Key? key}) : super(key: key);
static var classe;

  @override
  Widget build(BuildContext context) {

    if (Classe1.classe == null) {
      return Home();
    } else {print(classe);
      return Classe1.classe;
    }
  }
}
