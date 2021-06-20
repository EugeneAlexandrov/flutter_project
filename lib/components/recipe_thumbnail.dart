import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({Key? key, this.recipe}) : super(key: key);

  final SimpleRecipe? recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                child: Image.asset(
                  recipe?.dishImage??'assets/food_pics/food_banana.jpeg',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              recipe?.title ?? 'N/A',
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 1,
            ),
            Text(
              recipe?.duration ?? 'N/A',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
