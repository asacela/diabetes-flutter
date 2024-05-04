import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter/utils/colors.dart';
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
                width: 400,
                height: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Add Meal', // Text to be a heading
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        fontSize: 20, // Increase font size
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFieldInput(
                      hintText: 'Meal Name',
                      textInputType: TextInputType.text,
                      textEditingController: _mealNameController
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
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
