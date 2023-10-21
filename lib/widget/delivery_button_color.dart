

import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

// getStatusName(status) {
//   switch (status) {
//     case 6:
//       return Text(
//         "Failed",
//         style: TextStyle(
//             color: Colors.redAccent.shade700,
//             fontSize: setHeightValue(18),
//             fontWeight: FontWeight.bold),
//       );
//     case 5:
//       return Text(
//         "Completed",
//         style: TextStyle(
//             color: Colors.green.shade900,
//             fontSize: setHeightValue(18),
//             fontWeight: FontWeight.bold),
//       );
//     case 3:
//       return Text(
//         "Todo",
//         style: TextStyle(
//             color: Colors.yellow.shade700,
//             fontSize: setHeightValue(18),
//             fontWeight: FontWeight.bold),
//       );
//     case 8:
//       return Text(
//         "Arrived",
//         style: TextStyle(
//             color: Colors.green.shade900,
//             fontSize: setHeightValue(18),
//             fontWeight: FontWeight.bold),
//       );
//     default:
//       return Text("Departed",
//           style: TextStyle(
//               color: Colors.green,
//               fontSize: setHeightValue(18),
//               fontWeight: FontWeight.bold));
//   }
// }


Color getStatusByNum(number) {
  switch (number) {
    case 6:
      return Colors.redAccent.shade700;
    case 5:
      return Colors.green.shade900;
    case 3:
      return Colors.yellow.shade700;
    case 8:
      return Colors.green.shade900;
    default:
      return Colors.green;
  }
}
