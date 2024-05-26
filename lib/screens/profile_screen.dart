import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/utils/utils.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, dynamic>? _userData; // To store additional user data
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

    void logout() async {

    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().logoutUser();
  
    if(res == "success"){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute( 
        builder: (context) => 
          LoginScreen(),
        ),
      );
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset('assets/diabetEats_logo_.png',
          height: 40,
        ),
        actions: [
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _userData != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  CircleAvatar(
                    radius: 50,
                    // You can provide a backgroundImage property to show an image
                    backgroundImage: NetworkImage(_userData!['photoUrl']),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _userData!['username'] ?? "", // Display name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _userData!['email'] ?? "", // Email
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ElevatedButton(
                    onPressed: () {
                      // Add functionality here, such as navigating to edit profile screen
                    },
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(width: 10),
                     ElevatedButton(
                    onPressed: (logout),
                    child: Text('Sign Out'),
                  ),

                    ],
                  ),
                  
                ],
              )
            : CircularProgressIndicator(), // Show loading indicator if user data is being fetched
      ),
    );
  }
}
