import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/generated_meal_info_card.dart';
import 'package:instagram_flutter/widgets/log_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/openai_methods.dart';

class CarbCamScreen extends StatefulWidget {
  const CarbCamScreen({super.key});

  @override
  State<CarbCamScreen> createState() => _CarbCamScreenState();
}

class _CarbCamScreenState extends State<CarbCamScreen> {
  Uint8List? _image;
  bool _isGenerated = false;
  bool _isLoading = false;
  String? jsonResponse;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void getCarbEstimate() async {
    try {
      final res = await OpenAI_Methods().sendImageToGPT4Vision(file: _image!);

      setState(() {
        jsonResponse = res;
        _isGenerated = true;
        _isLoading = false;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset(
          'assets/diabetEats_logo_.png',
          height: 40,
        ),
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align the Row to the top vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the Row horizontally
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the buttons horizontally
              children: [
                ElevatedButton(
                  child: Text("Choose Image"),
                  onPressed: (selectImage),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text("Take Picture"),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 24),
            Stack(
              children: [
                Container(
                  height: 300.0,
                  width: 300.0,
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
                ),
                Positioned(
                  bottom: 16.0,
                  left: 70.0,
                  child: Container(
                    height: 40,
                    width: 160,
                    child: FloatingActionButton(
                      backgroundColor: blueColor,
                      onPressed: () {
                        // Handle FAB press
                        setState(() {
                          _isLoading = true;
                        });
                        getCarbEstimate();
                      },
                      child: Padding(
                        child: _isLoading
                            ? const Center(
                                child: SizedBox(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                                height: 20.0,
                                width: 20.0,
                              ))
                            : Row(
                                children: [
                                  Text(
                                    "Get Carb Estimate  ",
                                    style: TextStyle(
                                      fontSize:
                                          12.0, // Adjust font size as needed
                                      fontWeight: FontWeight
                                          .bold, // Adjust font weight as needed
                                      color: Colors
                                          .white, // Adjust text color as needed
                                    ),
                                  ),
                                  Icon(Icons.send),
                                ],
                              ),
                        padding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            _isGenerated ? GeneratedMealInfoCard(jsonMealContent: jsonResponse) :
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
