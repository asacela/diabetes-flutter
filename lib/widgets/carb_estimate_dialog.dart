import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class CarbEstimateDialog extends StatefulWidget {
  const CarbEstimateDialog({super.key});

  @override
  State<CarbEstimateDialog> createState() => _CarbEstimateDialogState();
}

class _CarbEstimateDialogState extends State<CarbEstimateDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, dynamic>? _userData; // To store additional user data
  bool generating = false;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void getCarbEstimate() async {
    String res = "some error occurred";
    setState(() {
      generating = true;
    });

    try {
      
      

    } catch (error) {

      showSnackBar(res, context);

    } finally {
      setState(() {
        generating = false;
      });
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
@override
Widget build(BuildContext context) {
  return SafeArea(child: Container());
}

}
