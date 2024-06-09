import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class GeneratedMealInfoCard extends StatefulWidget {
  final jsonMealContent;
  const GeneratedMealInfoCard({
    Key? key,
    required this.jsonMealContent,
  }) : super(key: key);

  @override
  _GeneratedMealInfoCardState createState() => _GeneratedMealInfoCardState();
}

class _GeneratedMealInfoCardState extends State<GeneratedMealInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: blueColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 150.0,
          width: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "This is text;",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Save Meal"))
            ],
          ),
        ));
  }
}
