import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key, required this.recipe}) : super(key: key);

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  recipe.backgroundImage ?? 'assets/magazine_pics/mag1.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          constraints: BoxConstraints.expand(
            width: 350,
            height: 450,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    recipe.title ?? 'N/A',
                    style: FooderlichTheme.darkTextTheme.headline2,
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ChipList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChipList extends StatelessWidget {
  const ChipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 12,
        children: [
          Chip(
            label:
                Text('Healthy', style: FooderlichTheme.darkTextTheme.bodyText1),
            backgroundColor: Colors.black.withOpacity(0.7),
            onDeleted: () {
              print('delete');
            },
          ),
          Chip(
            label:
                Text('Vegan', style: FooderlichTheme.darkTextTheme.bodyText1),
            backgroundColor: Colors.black.withOpacity(0.7),
            onDeleted: () {
              print('delete');
            },
          ),
          Chip(
            label:
                Text('Carrots', style: FooderlichTheme.darkTextTheme.bodyText1),
            backgroundColor: Colors.black.withOpacity(0.7),
            onDeleted: () {
              print('delete');
            },
          ),
          Chip(
            label:
                Text('Greens', style: FooderlichTheme.darkTextTheme.bodyText1),
            backgroundColor: Colors.black.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
