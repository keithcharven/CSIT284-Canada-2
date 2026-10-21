import 'package:flutter/material.dart';
import 'package:meals2/models/meal.dart';
import 'package:meals2/widgets/meal_item.dart';
import 'package:meals2/screens/meal_details.dart'; 

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (context, meal) { 
          selectMeal(context, meal);
        },
      ) 
    );
    
    if (meals.isEmpty) {
      content = Column(
        children: [
          Text(
            'Uh oh... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface
            )
          ),
          const SizedBox(height: 16,),
          Text(
            'Please select another category',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface
            )
          ),
        ],
      );
    }
    
    return Scaffold(
      appBar: AppBar(title: Text(title),
      ),
      body: content,
    );
  }
}