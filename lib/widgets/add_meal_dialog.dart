import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class AddMealDialog extends StatefulWidget {
  const AddMealDialog({super.key});

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  String dropdownValue = absorptionValues.first;
  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _mealNameController = TextEditingController();
    final TextEditingController _carbAmountController = TextEditingController();
    final TextEditingController _ingredientListController =
        TextEditingController();
    final TextEditingController _recipeController = TextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          height: 120.0,
          width: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: _image != null
                  ? MemoryImage(_image!) as ImageProvider
                  : NetworkImage(
                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.rectangle,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(
                      8.0), // Add some padding if necessary
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        36.0), // Set the desired border radius
                    child: Container(
                      width: 48.0, // Same width as default FAB divided bby 2
                      height: 48.0, // Same height as default FAB divided bby 2
                      child: FloatingActionButton(
                        onPressed: (selectImage),
                        child: const Icon(Icons.edit),
                        backgroundColor:
                            Colors.blue, // Replace with your secondaryColor
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0)), // Ensure shape matches the ClipRRect
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
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
        const SizedBox(height: 12),
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
            SizedBox(
              width: MediaQuery.of(context).size.width * (5 / 12),
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
        const SizedBox(height: 24),
        SizedBox(
          height: 150,
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
          height: 150,
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
          child: Text(
            'Save Meal',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Example style properties
              fontSize: 16, // Example style properties
              color: blueColor, // Example color
            ),
          ),
        ),
      ],
    );
  }
}
