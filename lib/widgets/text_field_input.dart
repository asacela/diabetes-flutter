import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key, 
    required this.textEditingController, 
    this.isPass = false, 
    required this.hintText, 
    required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double textFieldWidth = _calculateTextFieldWidth();

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context)
    );
    
    return Container(
      height: 35.0,
      width: textFieldWidth, // Set the width of the container
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }

  double _calculateTextFieldWidth() {
    if (textInputType == TextInputType.number || textInputType == TextInputType.phone || textInputType == TextInputType.datetime) {
      // Set width for numeric input types
      return 70.0; // You can adjust this value as needed
    } else {
      // Set default width for other input types
      return 250.0; // You can adjust this value as needed
    }
  }
}
