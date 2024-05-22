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

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Carbs Amount: ', // Text to be a heading
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 12, // Increase font size
              ),
            ),
            TextFieldInput(
                hintText: '(g)',
                textInputType: TextInputType.number,
                textEditingController: _carbAmountController),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Absorption Time: ', // Text to be a heading
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make it bold
                fontSize: 12, // Increase font size
              ),
            ),
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
        const SizedBox(height: 15),
        SizedBox(
          height: 200, 
          child: CupertinoTextField(
            controller: _ingredientListController,
            placeholder: "Bad",
            prefix: Text(
              'Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: const TextStyle(fontWeight: FontWeight.w400, color: secondaryColor),
            maxLines: 20,
            decoration: BoxDecoration(),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
