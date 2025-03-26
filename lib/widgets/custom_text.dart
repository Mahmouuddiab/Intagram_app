import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
   CustomText({super.key,required this.text,
     this.fontSize,this.fontWeight,
     this.color,this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),maxLines:maxLines ,
    );
  }
}
