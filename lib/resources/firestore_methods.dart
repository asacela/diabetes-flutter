import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/meal.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload meal
  Future<String> uploadMeal(
    String uid,
    String title,
    Uint8List file,
    String carbs,
    String ingredientList,
    String recipe,
    String absorptionTime,
  ) async {
    print("Uploading meal!");

    String res = "some error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage("meals", file, true);

      String mealId = const Uuid().v1();
      Meal meal = Meal(
        uid: uid,
        title: title,
        carbs: carbs,
        photoUrl: photoUrl,
        ingredientList: ingredientList,
        recipe: recipe,
        absorptionTime: absorptionTime,
        liked: false,
      );

      // Save the meal under the user's uid sub-collection
      await _firestore.collection('users').doc(uid).collection('meals').doc(mealId).set(
        meal.toJson(),
      );

      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}