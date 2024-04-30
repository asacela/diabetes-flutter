import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:image_card/image_card.dart';

class MealCard extends StatelessWidget {
  const MealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FillImageCard(
        width: 400,
        heightImage: 140,
        imageProvider: NetworkImage('https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        tags: [_tag('Lunch', () {}),],
        title: _title(color: textColor),
        description: _content(color: textColor),
        color: cardColor,
      ),
    );
  }

  Widget _title({Color? color}) {
    return Text(
      'Salmon Bowl',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget _content({Color? color}) {
    return Text(
      'Carb Amount: 30g',
      style: TextStyle(color: color),
    );
  }

  Widget _footer({Color? color}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/avatar.png',
          ),
          radius: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          'Super user',
          style: TextStyle(color: color),
        )),
        IconButton(onPressed: () {}, icon: Icon(Icons.share))
      ],
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