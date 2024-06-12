// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:google_ml_kit/google_ml_kit.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? _image;
//   String? _result = "Select an image";

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _analyzeImage(_image!);
//     }
//   }

//   Future<void> _analyzeImage(File image) async {
//     final inputImage = InputImage.fromFile(image);
//     final imageLabeler = GoogleMlKit.vision.imageLabeler();
//     final labels = await imageLabeler.processImage(inputImage);

//     if (labels.isEmpty) {
//       setState(() {
//         _result = "No food items recognized.";
//       });
//       return;
//     }

//     String foodItem = labels.first.label;

//     setState(() {
//       _result = "Detected: $foodItem";
//     });

//     double carbs = await _fetchCarbContent(foodItem);
//     setState(() {
//       _result = "$foodItem contains $carbs grams of carbs.";
//     });
//   }

//   Future<double> _fetchCarbContent(String foodItem) async {
//     final response = await http.get(Uri.parse('https://api.nutritionix.com/v1_1/search/$foodItem?results=0:1&fields=item_name,nf_total_carbohydrate&appId=YOUR_APP_ID&appKey=YOUR_APP_KEY'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['hits'].isNotEmpty) {
//         return data['hits'][0]['fields']['nf_total_carbohydrate'].toDouble();
//       }
//     }
//     return 0.0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carb Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(_image!),
//             SizedBox(height: 20),
//             Text(_result!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }