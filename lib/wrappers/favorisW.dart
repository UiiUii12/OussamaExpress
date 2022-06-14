import 'package:clientapp/Favoris.dart';
import 'package:clientapp/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../auth/user.dart';
import '../favorisPleine.dart';



class FavorisW extends StatelessWidget {
  const FavorisW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamBuilder<int>(
        stream: DatabaseService(uid: user!.uid).existfavoris,
        builder: (context, snapshot) {

          if (snapshot.hasData){
            if (snapshot.data==0){
              return  Favoris();
            }else{
              return FavorisPleine();
            }
          }else{
            return  Favoris();

          }
        }
    );
  }
}
