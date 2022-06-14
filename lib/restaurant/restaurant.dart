class Restaurant{
  final String nom ,imageUrl,id,phone;
  final double longitude,latitude;
  Restaurant({required this.nom,required this.longitude,required this.imageUrl,required this.latitude,required this.id,required this.phone});
}
class PartRestaurant{
  final String nom ,imageUrl;

  PartRestaurant({required this.nom,required this.imageUrl});
}
class Plat{
  final String id, resId,descreption,nom,categore;
  final int prix;
  Plat({required this.id,required this.nom,required this.resId,required this.descreption,required this.prix,required this.categore});
}