import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'images/Image1.png',
    title: "Le temps est précieux, n'est-ce pas ?",
    description: "Avec notre service rapide, vous n'aurez plus à vous soucier de l'heure de votre repas.",
  ),
  Slide(
    imageUrl: 'images/onboarding2.png',
    title: "Un seul clic et vous avez terminé !",
    description: "Le reste est sur nous, vous apportant votre nourriture préférée.",
  ),
  Slide(
    imageUrl: 'images/onboarding3.png',
    title: "Vous avez le dos !",
    description: "Quelques minutes et vous obtiendrez votre nourriture délicieuse et chaude.",
  ),
];