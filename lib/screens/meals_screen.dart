import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/add_meal_dialog.dart';
import 'package:instagram_flutter/widgets/meal_card.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  

  @override
  Widget build(BuildContext context) {

    final TextEditingController _mealNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/diabetEats_logo_.png',
          height: 40,
        ),
        actions: [],
      ),
      body: ListView(
        children: [
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: Container(
                width: 500,
                height: 500,
                child: AddMealDialog(),
              ),
            ),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: blueColor,
      ),
    );
  }
}
