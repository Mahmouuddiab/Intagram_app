import 'package:flutter/material.dart';
import 'package:instagram/widgets/custom_text.dart';

class UserInfo extends StatelessWidget {
  final String userImg,followersNmuber;
  const UserInfo({super.key,required this.userImg,required this.followersNmuber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [
              Colors.pinkAccent,
              Colors.orangeAccent
            ])
          ),
          child: CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(userImg),
          ),
        ),
        Column(
          children: [
            CustomText(text: "2",fontWeight: FontWeight.bold,fontSize: 18,),
            CustomText(text: "posts",fontWeight: FontWeight.bold,fontSize: 18,)
          ],
        ),
        Column(
          children: [
            CustomText(text: followersNmuber,fontWeight: FontWeight.bold,fontSize: 18,),
            CustomText(text: "followers",fontWeight: FontWeight.bold,fontSize: 18,)
          ],
        ),
        Column(
          children: [
            CustomText(text: "2",fontWeight: FontWeight.bold,fontSize: 18,),
            CustomText(text: "following",fontWeight: FontWeight.bold,fontSize: 18,)
          ],
        )
      ],
    );
  }
}
