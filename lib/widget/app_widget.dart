import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';
import 'package:readmore/readmore.dart';

getTableWidget(first, second, {double? textSize, textColor, maxLines}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$first : ',
        style: TextStyle(
            color: textColor ?? AppColors.textColor,
            fontSize: setHeightValue(textSize ?? 15),
            fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      Expanded(
        // child: ReadMoreText(
        //   second,
        //   trimLines: 2,
        //   trimMode: TrimMode.Line,
        //   trimCollapsedText: 'Show more',
        //   trimExpandedText: '...Show less',
        //   // style: TextStyle(
        //   //   color: color ?? textColor,
        //   //   fontSize: height * (textSize ?? 0.015),
        //   // ),
        //   // moreStyle: TextStyle(fontSize: 0.016, fontWeight: FontWeight.bold, color: alterColor),
        //   // lessStyle: TextStyle(fontSize: 0.016, fontWeight: FontWeight.bold, color: alterColor),
        //   preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
        //   style: TextStyle(color: Colors.black),
        //   colorClickableText: Colors.pink,
        // ),
        child: Text(
          second,
          style: TextStyle(
            color: textColor ?? AppColors.textColor,
            fontSize: setHeightValue(textSize ?? 15),
          ),
          maxLines: maxLines ?? 2,
        ),
      ),
    ],
  );
}
