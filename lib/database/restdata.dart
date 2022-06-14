import 'dart:async';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestauService {

static String plasImage ="",foodImage="",name="";
final CollectionReference restauCollection = FirebaseFirestore.instance.collection('Restaurant');
  
  List <String> _sugestion(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return doc.get("ImageUrl").toString();


    }).toList();

  }
  Stream<List <String>> get sugestion {
    return restauCollection.snapshots().map((snapshot)=> _sugestion(snapshot));

  }
  List <String> _promotion(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return doc.get("ImageUrl").toString();


    }).toList();

  }
  Stream<List <String>> get promotion {
    return FirebaseFirestore.instance.collection('Promotion').snapshots().map((snapshot)=> _promotion(snapshot));

  }


  List <Restaurant> _restaurantList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return Restaurant(nom: doc.get("nom").toString(), longitude: doc.get("longitude").toDouble(), imageUrl: doc.get("ImageUrl").toString(), latitude:doc.get("latitude").toDouble(), id: doc.get("ID").toString(), phone: doc.get("phone").toString());


    }).toList();

  }
  Stream<List <Restaurant>> get restaurantList {
    return restauCollection.snapshots().map((snapshot)=> _restaurantList(snapshot));

  }

  PartRestaurant _partRestau(DocumentSnapshot snapshot){
    return  PartRestaurant(nom: snapshot.get("nom"), imageUrl: snapshot.get("ImageUrl"));
  }

  Stream <PartRestaurant>  partRestau (String uid){

    return restauCollection.doc(uid).snapshots().map((snapshot) => _partRestau(snapshot));
  }


  List <Plat> _categoreList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {
      print( doc.get("nom").toString());
      print( doc.get("prix").toString());
      print("hi");
      return Plat(id: doc.get("ID").toString(), nom:doc.get("nom").toString(), resId: doc.get("ResID").toString(), descreption: doc.get("description").toString(), prix: doc.get("prix").toInt(), categore: doc.get("categorie").toString());


    }).toList();

  }
  Stream<List <Plat>> categoreList (String uid,String categorie){

    return restauCollection.doc(uid).collection(categorie).snapshots().map((snapshot)=> _categoreList(snapshot));

  }

  List<String> _tabcate(DocumentSnapshot snapshot){
    var t =  snapshot.get("Categories");

    List<String> z=[];
    for(int i=0;i<t.length;i++){
    z.add(t[i].toString());}
    return  z;
  }

  Stream <List<String>> tabcate(String id){

    return restauCollection.doc(id).snapshots().map((snapshot) => _tabcate(snapshot));
  }
 getfoodImage(String cate)  {


 if(cate=="Pizzas"){
   foodImage="images/pizza.png";

 }
 else if(cate=="Burger"){
   foodImage="images/burger.png";
 }else if(cate=="Tacos"){
   foodImage="images/tacos.png";
 }else{
   foodImage="images/chicken.png";
 }
}
 getplatImage(String cate)  {

if(cate=="Pizzas"){
  plasImage="images/pizzap.png";

}
else if(cate=="Burger"){
  plasImage="images/burgerp.png";
}else if(cate=="Tacos"){
  plasImage="images/chickenp.png";
}else {
  plasImage="images/chickenp.png";
}

}

String nom(String id){
   restauCollection.doc(id).get().then((value) => name= value.get("nom"));

    return name;

  }


}