import 'package:clientapp/Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

import 'Onboarding.dart';
import 'auth/user.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return OnBoarding();
    } else {
      return Main_Page();
    }
  }
}
