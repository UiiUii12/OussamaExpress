import 'package:clientapp/auth/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference livreurCollection = FirebaseFirestore.instance.collection('livreur');
  // convert FirebaseUser to MyUser
  MyUser? _useFromFireBaseUser(User? user){
    if (user != null) {
      return MyUser(uid: user.uid,phone: user.phoneNumber );
    } else {
      return null;
    }
  }
  // auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map((user) => _useFromFireBaseUser(user));

  }
// signe out
  Future singeOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return null ;
    }
  }
// signe in anon
Future signeInAnon()async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user=result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
}



}