import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key, required this.recipe}) : super(key: key);

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage??'assets/magazine_pics/mag1.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Text(
              recipe.subtitle??'N/A',
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
              child: Text(
                recipe.title??'N/A',
                style: FooderlichTheme.darkTextTheme.headline2,
              ),
              top: 20,
            ),
            Positioned(
              child: Text(
                recipe.message??'N/A',
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
              bottom: 30,
              right: 0,
            ),
            Positioned(
              child: Text(
                recipe.authorName??'N/A',
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
              bottom: 10,
              right: 0,
            )
          ],
        ),
      ),
    );
  }
}
