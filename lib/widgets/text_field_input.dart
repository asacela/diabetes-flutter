import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String inputSuffix;

  const TextFieldInput({
    Key? key, 
    required this.textEditingController, 
    this.isPass = false, 
    this.inputSuffix = "",
    required this.hintText, 
    required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = _calculateTextFieldWidth();

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );

        Widget? suffixWidget;

    // Check if suffix is not null and not empty
    if (inputSuffix != null && inputSuffix!.isNotEmpty) {
      // If inputSuffix is a string, convert it to a Text widget
      suffixWidget = Text(inputSuffix!);
    } else {
      suffixWidget = null; // Set to null if suffix is empty
    }
    
    return Container(
      height: 35.0,
      width: textFieldWidth, // Set the width of the container
      child: CupertinoTextField(
        controller: textEditingController,
        decoration: BoxDecoration(),
        keyboardType: textInputType,
        obscureText: isPass,
        placeholder: hintText,
        style: const TextStyle(fontWeight: FontWeight.w400, color: secondaryColor),
        suffix: suffixWidget,
      ),
    );
  }

  double _calculateTextFieldWidth() {
    if (textInputType == TextInputType.number || textInputType == TextInputType.phone || textInputType == TextInputType.datetime) {
      // Set width for numeric input types
      return 90.0; // You can adjust this value as needed
    } else {
      // Set default width for other input types
      return 250.0; // You can adjust this value as needed
    }
  }
}
