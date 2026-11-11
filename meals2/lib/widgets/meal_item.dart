import 'package:flutter/material.dart';
import 'package:meals2/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key, 
    required this.meal,
    required this.onSelectMeal, 
  });
  
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onSelectMeal; 

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell( 
        onTap: () {
          onSelectMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Text(meal.title)
            ),
          ],
        ),
      ),
    );
  }
}