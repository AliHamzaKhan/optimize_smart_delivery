

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';

import '../config/app_enviroment/app_environment.dart';
import '../config/helper/my_utils.dart';
import '../modules/order/model/delivery_item.dart';

class ItemDesign extends StatelessWidget {
   ItemDesign({Key? key, this.item}) : super(key: key);
   ItemData? item;
   File? image;
   var orderController;
   var onImageSelect;
   var onQuantitySelected;
   var quantityController = TextEditingController();

   var qty = 0;
  @override
  Widget build(BuildContext context) {
    qty = item!.qty!;
    print(AppEnvironment.IMAGE_URL+ item!.photopath!);
    return Container(
      width: kWidth,
      padding: EdgeInsets.symmetric(vertical: setHeightValue(7), horizontal: setHeightValue(5)),
      // margin: EdgeInsets.symmetric(horizontal: setHeightValue(5)),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(setHeightValue(10)),
          //   bottomRight: Radius.circular(setHeightValue(10)),
          // ),
          color: AppColors.subBackgroundColor),
      child: Row(
        children: [
          setHeight(5),
          Expanded(
              flex: 3,
              child: Text(
                item!.itemName ?? "",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: setHeightValue(15)),
                textAlign: TextAlign.start,
              )),
          Expanded(
              flex: 1,
              child: Text(
                item!.itemUnit ?? "",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: setHeightValue(15)),
                textAlign: TextAlign.center,
              )),


          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(

                    onTap: (){
                      qty =    qty + 1 ;
                      onQuantitySelected(qty);

                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      // width: Get.height * 0.015,
                      // height: Get.height * 0.020,
                      padding: EdgeInsets.symmetric(
                          horizontal: setHeightValue(5)
                      ),
                      color: AppColors.appbackgroundColor,
                      child: Text('+', style: TextStyle(color: AppColors.alterColor, fontSize: setHeightValue(30)),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: setHeightValue(10)
                    ),
                    child : AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder: (Widget child, Animation<double> animation){
                        return SlideTransition(
                          child: child,
                          position: Tween<Offset>(
                              begin: Offset(0.0, -0.5),
                              end: Offset(0.0, 0.0))
                              .animate(animation),
                        );
                      },
                      child: Text(

                        '${qty.toString()}',
                        key: ValueKey<String>(item!.qty.toString()),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: setHeightValue(25)),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ),
                  GestureDetector(
                    onTap: (){
                      if(qty > 0){
                        qty =  qty - 1 ;
                        onQuantitySelected(qty);
                      }


                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      // width: Get.height * 0.015,
                      // height: Get.height * 0.020,
                      margin: EdgeInsets.only(
                          right: setHeightValue(5)
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: setHeightValue(5)
                      ),
                      color: AppColors.appbackgroundColor,
                      child: Text('−', style: TextStyle(color: AppColors.alterColor, fontSize: setHeightValue(30)),),
                    ),
                  ),
                ],
              )),
          GestureDetector(
            onTap: () async {
              image = await getFromCamera();
              onImageSelect(image);
            },
            child: Container(
              width: setHeightValue(50),
              height: setHeightValue(50),
              child : image == null ?
              // CachedNetworkImage(
              //   imageUrl: MyApi.IMAGE_BASE_URL + item!.photopath!,
              //   imageBuilder: (context, imageProvider) => Container(
              //     width: height * 0.050,
              //     height: height * 0.050,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: imageProvider,
              //           fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              //   placeholder: (context, url) => Icon(
              //     Icons.image,
              //     size: height * 0.040,
              //   ),
              //   errorWidget: (context, url, error) =>  Icon(
              //     Icons.image,
              //     size: height * 0.040,
              //   ),
              // )
              ClipRRect(
                borderRadius: BorderRadius.circular(setHeightValue(5)),
                child: Image.network(
                  width: setHeightValue(50),
                  height: setHeightValue(50),
                  AppEnvironment.IMAGE_URL + item!.photopath!,
                  fit: BoxFit.cover,
                  errorBuilder: ( context, exception,
                      stackTrace) {
                    return Icon(
                      Icons.image,
                      size: setHeightValue(40),
                    );
                  },),
              )                  :

              ClipRRect(
                borderRadius: BorderRadius.circular(setHeightValue(5)),
                child: Image.file(
                  image!,
                  width: setHeightValue(40),
                  height: setHeightValue(35),
                  fit: BoxFit.cover,
                ),
              ),

              //   child: image == null
              //       ? (( item!.photopath == '' || item!.photopath == 'null' || item!.photopath == null) ?
              //   Icon(
              //     Icons.image,
              //     size: height * 0.040,
              //   ) :
              //   Image.network(MyApi.IMAGE_BASE_URL + item!.photopath!,
              //     width: height * 0.040,
              //     height: height * 0.035,
              //     fit: BoxFit.cover,))
              //       : ClipRRect(
              //     borderRadius: BorderRadius.circular(height * 0.005),
              //         child: Image.file(
              //     image!,
              //     width: height * 0.040,
              //     height: height * 0.035,
              //     fit: BoxFit.cover,
              //   ),
              //       ),
            ),
          )
        ],
      ),
    );
  }
}
