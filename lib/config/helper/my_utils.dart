import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';

Future<String> convertImageIntoBase64(File image) async {
  List<int> imageBytes = await image.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

Future<String> base64encodedImage(List<int> imageDataBytes) async {
  try {
    final String base64Data = base64Encode(imageDataBytes);
    return base64Data;
  } catch (error) {
    appDebugPrint('Error encoding image: $error');
    return '';
  }
}

launchMapViaAddress(String address) async {
  String encodedAddress = Uri.encodeComponent(address);
  var uri = Uri.parse("google.navigation:q=$encodedAddress&mode=d");
  String googleMapUrl =
      "https://www.google.com/maps/search/?api=1&query=$encodedAddress";
  String appleMapUrl = "http://maps.apple.com/?q=$encodedAddress";
  if (Platform.isAndroid) {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (error) {
      throw ("Cannot launch Google map");
    }
  }
  if (Platform.isIOS) {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (error) {
      throw ("Cannot launch Apple map");
    }
  }
}

Future<File?> getFromCamera() async {
  var pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    return imageFile;
  } else {
    return null;
  }
}

// Future<File?> openInternalStorage({allowedExtensions}) async{
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     allowMultiple: false,
//     type: FileType.custom,
//     allowedExtensions:allowedExtensions ?? ['jpg', 'pdf', 'doc'],
//   );
//
//   if (result != null) {
//     File file = File(result.files.single.path!);
//     return file;
//   }
//   else {
//     return null;
//   }
// }

// getAddressFromLocation(String location) async{
//   if(location == ''){
//     return;
//   }
//   var temp = location.split(',');
//   var position = LatLng(double.parse(temp[0]), double.parse(temp[1]));
//   List<Placemark> address = await placemarkFromCoordinates(position.latitude, position.longitude);
//   var a = '${address[0].country} ${address[0].administrativeArea} ${address[0].street} ${address[0].subAdministrativeArea} ${address[0].subThoroughfare}';
//   appDebugappDebugPrint(a);
//   appDebugappDebugPrint(address);
//   return a;
// }
//
// getLocationFromAddress(String address) async{
//
//   List<Location> locations = await locationFromAddress(address);
//   appDebugappDebugPrint("locations");
//   appDebugappDebugPrint(locations[0]);
//
//   return LatLng(locations[0].latitude, locations[0].longitude);
//
// }

class DistanceCal{

  kmToMm(value){
    var a = value / 1000;
    return a;
  }
}
class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 1,
        color: AppColors.textColor,
      ),
    );
  }
}
appDebugPrint(msg) {
  if (kDebugMode) {
    print(msg);
  }
}
