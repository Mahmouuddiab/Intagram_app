import 'package:flutter/material.dart';
import 'package:instagram/widgets/custom_text.dart';

class CategoryInfo extends StatelessWidget {
  final List img;
  final String category;
   CategoryInfo({super.key,required this.img,required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        CustomText(text: category,fontWeight: FontWeight.bold,color: Colors.white,),
        SizedBox(height: 9,),
        Row(
          children: [
            Transform.rotate(
              angle: -10,
                child: Icon(Icons.link)),
            SizedBox(width: 5,),
            CustomText(text: "https://jednravin.com",fontWeight: FontWeight.bold,)
          ],
        ),
        SizedBox(height: 9,),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: (img.length*27.0)+10,
              child: Stack(
                children: [
                  for(int i=0;i<img.length;i++)
                    Positioned(
                        left: i*22.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 20,
                          child: CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(img[i]),
                          ),
                    ))
                ],
              ),
            ),
            SizedBox(width: 4,),
            SizedBox(
              width: 280,
              child: CustomText(
                text: "followed by vot44,mahmoud,messi ,ronaldo",
                fontWeight: FontWeight.bold,maxLines: 2,),
            )
          ],
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  CustomText(text: "following",fontWeight: FontWeight.bold,),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  CustomText(text: "message",fontWeight: FontWeight.bold,),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Icon(Icons.person_add_alt)
            )
          ],
        ),
      ],
    );
  }
}
