import 'package:clientapp/Profile.dart';
import 'package:clientapp/profileInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'auth/user.dart';


class Wrapper2 extends StatelessWidget {
  const Wrapper2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user!.phone == null|| user.phone=="") {
      return Profile();

    } else {
      return Profile_Infos();
    }
  }
}
