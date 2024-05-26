import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/meal.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/add_meal_dialog.dart';
import 'package:instagram_flutter/widgets/meal_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, dynamic>? _userData; // To store additional user data
  bool _isLoading = false;

  final TextEditingController _mealNameController = TextEditingController();
  List<Meal> _meals = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();

    if (_currentUser != null){
      _fetchMeals();
    }
  }

  Future<void> _getCurrentUser() async {
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      // Get additional user data from Firestore
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      setState(() {
        _userData = userDataSnapshot.data() as Map<String, dynamic>?;
      });
    }
  }

  Future<void> _fetchMeals() async {
    String uid = _currentUser!.uid; // Replace with actual user ID logic
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('meals')
          .get();

      List<Meal> meals = snapshot.docs
          .map((doc) => Meal.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (err) {
      print("Error fetching meals: $err");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _mealNameController.dispose();
    super.dispose();
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                return MealCard(
                  imageUrl: meal.photoUrl,
                  title: meal.title,
                  description: 'Carb Amount: ${meal.carbs}g',
                  tag: 'Meal Tag', // Replace with actual tag if available
                  onTap: () {
                    // Handle onTap event
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                insetPadding: EdgeInsets.all(0), // Removes default padding
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Add Meal'),
                    ),
                    body: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AddMealDialog(),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: blueColor,
      ),
    );
  }
}
