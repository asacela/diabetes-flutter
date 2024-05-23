import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    var mySnapData = (snap.data() as Map<String, dynamic>);
    return model.User(
      followers: mySnapData['followers'],
      email: mySnapData['email'],
      uid: mySnapData['uid'],
      bio: mySnapData['bio'],
      following: mySnapData['following'],
      username: mySnapData['username'],
      photoUrl: mySnapData['photoUrl'],
    );

  }

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty  || file != null)
      {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        
        print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        // add user to database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
          bio: bio,
          followers: [],
          following: [],
        ); 

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);

        res = 'success';
      }
    } on FirebaseAuthException catch(error) {

      if (error.code == "invalid-email"){
        res = "The email is badly formatted.";
      }

      if (error.code == "weak-password"){
        res = "The password should be at least 6 characters.";
      }
    } 
    
    catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res= "Some error occurred";

    try {
      if(email.isNotEmpty || password.isNotEmpty){

        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";

      }
    } on FirebaseAuthException catch(error) {
      if(error.code == "user-not-found"){
        res = "User Not Found !";
      }
      else if(error.code == "wrong-password"){

        res = "Wrong Password!";

      }
    } 
    catch(error){
      res = error.toString();
    }
    return res;
  }

  Future<String> logoutUser() async {
    
    String res= "Some error occurred";
    try {
      await _auth.signOut();
      res = "success";
    }
    catch(error){
      res = error.toString();
    }
    return res;

  }
}