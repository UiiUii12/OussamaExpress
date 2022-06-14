
import 'package:clientapp/wrappers/panierW.dart';
import 'package:flutter/cupertino.dart';


class Classe2 extends StatelessWidget {
  Classe2({Key? key}) : super(key: key);
  static var classe;
  @override
  Widget build(BuildContext context) {

    if (classe == null) {
      return PanierW();
    } else {
      return classe;
    }
  }
}
