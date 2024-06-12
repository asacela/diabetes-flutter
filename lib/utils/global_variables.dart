import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/carb_cam_screen.dart';
import 'package:instagram_flutter/screens/meals_screen.dart';
import 'package:instagram_flutter/screens/profile_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
          FeedScreen(),
          CarbCamScreen(),
          ProfileScreen(),
];

const List<String> absorptionValues = <String>['Slow', 'Medium', 'Fast'];

String OPENAI_BASE_URL = "https://api.openai.com/v1";
