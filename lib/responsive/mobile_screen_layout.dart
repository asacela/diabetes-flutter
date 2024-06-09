
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/global_variables.dart';


class mobileScreenLayout extends StatefulWidget {


  const mobileScreenLayout({Key? key}) : super(key: key);

  @override 
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();

}
class _mobileScreenLayoutState extends State<mobileScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {

    pageController.jumpToPage(page);


  }

  void onPageChanged(int page)
  {
    setState(() {
      _page = page;
    });
  }  
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        child: CupertinoTabBar(
          items:  [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  Icons.restaurant_menu,
                  color: _page == 0 ? blueColor  : secondaryColor,
                )
              ), 
              label: 'meals', 
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  Icons.photo_camera,
                  color: _page == 1 ? blueColor  : secondaryColor,
                )
              ), 
              label: 'carb cam', 
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  Icons.person,
                  color: _page == 2 ? blueColor  : secondaryColor,
                )
              ), 
              label: 'profile', 
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTapped,
        )
      ),
    );
  }
}