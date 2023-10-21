import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/Widget/app_button.dart';
import 'package:optimize_smart_delivery/config/parser/data_parser_service.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

import '../config/helper/my_utils.dart';
import '../modules/order/controller/order_controller.dart';
import '../modules/order/model/order_type.dart';
import '../modules/order/model/task.dart';
import 'app_widget.dart';
import 'delivery_button_color.dart';

@immutable
class OrderListingCard extends StatelessWidget {
  OrderListingCard(
      {Key? key,
      this.order,
      this.onTap,
      // required this.orderController,
      this.isResetButton = false,
      this.onResetClick})
      : super(key: key);

  Rows? order;
  var onTap;

  // OrderController orderController;
  bool isResetButton;
  var onResetClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: setHeightValue(10), vertical: setHeightValue(10)),
        margin: EdgeInsets.only(
          top: setHeightValue(5),
          bottom: setHeightValue(5),
          left: setHeightValue(10),
          right: setHeightValue(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(setHeightValue(10)),
          color: AppColors.subBackgroundColor,
        ),
        child: Column(
          children: [
            setHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order!.deliveryrefno!,
                  style: TextStyle(
                      color: AppColors.alterColor,
                      fontSize: setHeightValue(22),
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: setHeightValue(10),
                        vertical: setHeightValue(5)),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //    border: Border.all(color: getColor(order!.statusid))
                    // ),
                    child: Text(
                      getNameByStatusNum(order!.statusid),
                      style: TextStyle(
                          color: getStatusByNum(order!.statusid),
                          fontWeight: FontWeight.bold,
                          fontSize: setHeightValue(20)),
                    ),
                  ),
                ),
              ],
            ),
            setHeight(10),
            getTableWidget(
                'Address', dataParser.getString(order!.deliveryaddress!)),
            setHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (order!.timeFrom! != '')
                  Expanded(
                    child: getTableWidget('From', order!.timeFrom!),
                  ),
                if (order!.timeTo! != '')
                  Expanded(
                    child: getTableWidget('To', order!.timeTo!),
                  )
              ],
            ),
            setHeight(10),
            if (order!.tel != '') getTableWidget('Tel', "${order!.tel}"),
            if (order!.notes != '') getTableWidget('Notes', "${order!.notes}"),
            setHeight(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(DistanceCal()
                        .kmToMm(order!.distance)
                        .toStringAsFixed(1)),
                    setWidth(5),
                    Text("Km"),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    await launchMapViaAddress(order!.deliveryaddress!);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Map ",
                        style: TextStyle(
                            color: AppColors.alterColor,
                            fontSize: setHeightValue(17)),
                      ),
                      Icon(
                        Icons.location_on,
                        color: AppColors.alterColor,
                        size: setHeightValue(18),
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (isResetButton)
              AppButton(
                title: 'Reset Order',
                onTap: onResetClick,
                btnWidth: 150,
                btnHeight: 35,
                btnColor: Colors.transparent,
                isOutline: true,
                btnRadius: 5,
                textColor: Colors.redAccent,
              )

          ],
        ),
      ),
    );
  }

// checkValue(value)   {
//   switch (value) {
//     case 3:
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//               onPressed: () async {
//                 order!.statusid = 8;
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: Colors.green,
//                     )),
//                 child: Text(
//                   "Arrived",
//                   style: TextStyle(
//                       color: Colors.green,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )),
//
//         ],
//       );
//     case 6:
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//               onPressed: () async {
//                 order!.statusid = 7;
//               },
//               child: Text(
//                 "Departed",
//                 style: TextStyle(
//                     color: Colors.green.shade900,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               )),
//         ],
//       );
//     case 5:
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           SizedBox(height: 25),
//           TextButton(
//               onPressed: () async {
//                 order!.statusid = 7;
//
//               },
//               child: Text(
//                 "Departed",
//                 style: TextStyle(
//                     color: Colors.green.shade900,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               )),
//         ],
//       );
//     case 8:
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//               onPressed: () async {
//                 order!.statusid = 5;
//
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: Colors.green.shade900,
//                     )),
//                 child: Text(
//                   "Completed",
//                   style: TextStyle(
//                       color: Colors.green.shade900,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )),
//           TextButton(
//               onPressed: () async {
//                 order!.statusid = 6;
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: Colors.redAccent.shade700,
//                     )),
//                 child: Text(
//                   "Failed",
//                   style: TextStyle(
//                       color: Colors.redAccent.shade700,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               )),
//         ],
//       );
//     case 7:
//       return SizedBox();
//   }
// }
}
