import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class AddMealDialog extends StatefulWidget {
  const AddMealDialog({super.key});

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  String dropdownValue = absorptionValues.first;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mealNameController = TextEditingController();
    final TextEditingController _carbAmountController = TextEditingController();
    final TextEditingController _ingredientListController = TextEditingController();
    final TextEditingController _recipeController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFieldInput(
                hintText: 'Meal Name',
                textInputType: TextInputType.text,
                textEditingController: _mealNameController),
            TextFieldInput(
                hintText: '(g)',
                textInputType: TextInputType.number,
                textEditingController: _carbAmountController,
                inputSuffix: "carbs"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            const Text(
              'Absorption Time: ', // Text to be a heading
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 12,
                color: secondaryColor, // Increase font size
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * (4 / 12),),
            DropdownButton<String>(
              value: dropdownValue,
              items: absorptionValues
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 175,
          child: CupertinoTextField(
            controller: _ingredientListController,
            placeholder: "Enter Ingredients",
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
            maxLines: null,
            textAlignVertical: TextAlignVertical.top, // Align text to the top
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10), // Add rounded corners
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 175,
          child: CupertinoTextField(
            controller: _recipeController,
            placeholder: "Enter Recipe",
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
            maxLines: null,
            textAlignVertical: TextAlignVertical.top, // Align text to the top
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10), // Add rounded corners
            ),
          ),
        ),
        SizedBox(height: 24), // Add spacing between text field and button
        ElevatedButton(
          onPressed: () {
            // Add your button onPressed logic here
            print('Button pressed');
          },
          child: Text('Save Meal'),
        ),
      ],
    );
  }
}
