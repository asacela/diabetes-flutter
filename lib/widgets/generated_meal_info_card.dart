import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class GeneratedMealInfoCard extends StatelessWidget {
  final Map<String, dynamic> jsonMealContent;

  const GeneratedMealInfoCard({
    Key? key,
    required this.jsonMealContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0, // Increased height to prevent overflow
      width: 310.0,
      child: Card(
        color: cardColor,
        elevation: 6.0,
        shadowColor: mobileBackgroundColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding to the container
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align items to the start
            children: <Widget>[
              Text(
                "Meal",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold, // Make the label bold
                  color: primaryTextColor,
                ),
              ),
              SizedBox(
                  height: 5.0), // Add some space between the label and value
              Text(
                jsonMealContent["meal"]["name"].toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: secondaryTextColor,
                ),
              ),
              SizedBox(height: 10.0), // Add some space between sections
              Text(
                "Total Carbs",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold, // Make the label bold
                  color: primaryTextColor,
                ),
              ),
              SizedBox(
                  height: 5.0), // Add some space between the label and value
              Text(
                jsonMealContent["meal"]["total_carbohydrates"].toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: secondaryTextColor,
                ),
              ),
              Spacer(), // Push the button to the bottom
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align the button to the right
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child:
                        Text("Save Meal", style: TextStyle(color: blueColor)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
