import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(
              right: 0,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://plus.unsplash.com/premium_photo-1689247409711-f70c5cfa9254?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('username',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ))),
                IconButton(
                  onPressed: () {
                  showDialog(context: context, builder: (context) => Dialog(

                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16,),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                      ]
                      .map((e) => InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric( vertical: 12, horizontal: 16,),
                          child: Text(e),
                        ),
                      ),
                      ).toList(),
                    ),
                  ),
                  );
                }, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
