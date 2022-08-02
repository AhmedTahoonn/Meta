import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 String ?uId='';
String convertDateFromString(String strDate){
  DateTime todayDate = DateTime.parse(strDate);
  var f=formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':',' ', am]);
  return f;
  }
  ///////////////////////////////////////////////////////////////////////////

  class shimmer extends StatelessWidget {
    final double ?height;
    final double ?width;
   shimmer({
      this.height,
     this.width
  });

   @override
    Widget build(BuildContext context) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
      );
    }
  }
