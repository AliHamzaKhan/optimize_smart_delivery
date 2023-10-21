import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/modules/order/model/delivery_item.dart';
import 'package:optimize_smart_delivery/widget/table_header.dart';

import '../config/theme/app_colors.dart';
import '../modules/order/controller/item_drawer_controller.dart';
import '../modules/order/controller/order_controller.dart';
import 'item_design.dart';

class OrderItemsDrawer extends StatelessWidget {
  OrderItemsDrawer({Key? key}) : super(key: key);

  var controller = Get.put(ItemDrawerController());
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: setWidthValue(100),
                  height: setWidthValue(100),
                  margin: EdgeInsets.only(top: setWidthValue(15)),
                  decoration: BoxDecoration(
                      color: AppColors.appbackgroundColor,
                      borderRadius: BorderRadius.circular(45)
                  ),
                  child: IconButton(
                    onPressed: (){
                      orderController.closeDrawer();
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined, size: setWidthValue(60)),

                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                width: kWidth * 0.9,
                color: AppColors.appbackgroundColor,
                child: Column(
                  children: [
                    tableHeader(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index){
                        return ItemDesign(
                          item: ItemData(
                            qty: 10,
                            itemId: 10,
                            deliveryid: 10,
                            itemUnit: 'unit',
                            itemName: 'item name',
                            deliveryrefno: '9871',
                            photopath: ''
                          ),
                        );

                      }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
