import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text ;
  final double size ;
  final FontWeight thisfontWeight ;
  final Color textColor ;
  final double spacing ;
  final TextAlign textAlign;

  const MyText({super.key, required this.text, required this.size, required this.thisfontWeight,
   required this.textColor, this.spacing = 0,this.textAlign= TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return  Text(text,
    
            softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.visible,
    style: TextStyle(
     
               fontFamily: "CormorantGaramond", 
                fontSize: size,
                fontWeight: thisfontWeight,
                color:textColor,
                letterSpacing: spacing,
                
                
              ),
              textAlign: textAlign,);
  }
}