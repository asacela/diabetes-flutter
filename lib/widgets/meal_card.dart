import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:image_card/image_card.dart';

class MealCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String tag;
  final VoidCallback onTap;

  const MealCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.tag,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: mobileBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FillImageCard(
          width: 400,
          heightImage: 140,
          imageProvider: NetworkImage(imageUrl),
          tags: [_tag(tag, () {})],
          title: _title(color: primaryTextColor),
          description: _content(color: secondaryTextColor),
          color: cardColor,
        ),
      ),
    );
  }

  Widget _title({Color? color}) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget _content({Color? color}) {
    return Text(
      description,
      style: TextStyle(color: color),
    );
  }

  Widget _tag(String tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
