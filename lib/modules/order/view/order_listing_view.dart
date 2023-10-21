import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/config/responsive/size_config.dart';
import 'package:optimize_smart_delivery/config/routes/app_routes.dart';
import 'package:optimize_smart_delivery/config/theme/app_colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../Widget/app_button.dart';
import '../../../Widget/driver_drawer.dart';
import '../../../Widget/order_listing_card.dart';
import '../controller/order_controller.dart';
import '../model/task.dart';

class OrderListingView extends GetView<OrderController> {
  OrderListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textColor),
        title: Text(
          'Orders',
          style: TextStyle(color: AppColors.textColor),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh, size: setHeightValue(30),color: AppColors.alterColor,)),
          toggleButton(),
        ],
      ),
      body: Obx(() => controller.getFilteredType() == 'All'
          ? allView()
          : todoView()),
      drawer: DriverDrawer(),
      bottomNavigationBar: Obx(() =>  Container(
        height: setHeightValue(60),
        decoration: BoxDecoration(
            color: AppColors.alterColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(setHeightValue(30)),
              topRight: Radius.circular(setHeightValue(30)),
            )),
        alignment: Alignment.center,
        child:  Text(
          controller.deliveryStatus.value,
          style: TextStyle(
              color: AppColors.subBackgroundColor,
              fontSize: setHeightValue(20),
              fontWeight: FontWeight.bold),
        ),
      ))
    );
  }

  allView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.ordersList.length,
        itemBuilder: (context, index) {
          return OrderListingCard(
            key: Key("${controller.ordersList[index].visitorderno}"),
            order: controller.ordersList[index],
            isResetButton: controller.ordersList[index].statusid == 3 ? false : true,
            onResetClick: (){

            },
            onTap: (){
              Get.toNamed(AppRoutes.orderRunningView);
            },
          );
        },
        );
  }

  todoView() {
    return Column(
      children: [
        AppIconButton(

          title: 'START',
          onTap: () async{
            Get.toNamed(AppRoutes.orderRunningView);
            // await controller.getTodo();
            // Get.to(() => NewOrderRunningScreen(
            //   orderController: orderController,
            // ));
          },
          icon: Icons.fast_forward_outlined,
          iconColor: AppColors.appbackgroundColor,
          textColor: AppColors.appbackgroundColor,
          btnColor: AppColors.alterColor,
          margin: 50,
          isOutline: false,
          alignment: MainAxisAlignment.center,
            centerPadding : 10,
            btnRadius : 10
        ),
        Expanded(
          child: ReorderableListView.builder(
              itemCount: controller.todoList.length,
              itemBuilder: (context, index) {
                return OrderListingCard(
                  key: Key("${controller.todoList[index].visitorderno}"),
                  order: controller.todoList[index],
                  onTap: (){
                    Get.toNamed(AppRoutes.orderRunningView);
                  },
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Rows movedItem = controller.todoList.removeAt(oldIndex);
                controller.todoList.insert(newIndex, movedItem);
                controller.reOrderVisit(movedItem.deliveryid!, newIndex + 1);
              }),
        )
      ],
    );
  }

  toggleButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ToggleSwitch(
        minWidth: setWidthValue(150),
        minHeight: setHeightValue(25),
        fontSize: setHeightValue(16),
        initialLabelIndex: 0,
        activeBgColor: [AppColors.alterColor],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: AppColors.textColor,
        totalSwitches: controller.filterTypes.length,
        labels: controller.filterTypes,
        onToggle: (index) {
          controller.selectedFilteredTypes(index);
          print('switched to: $index');
          print('switched to: ${controller.getFilteredType()}');
        },
      ),
    );
  }
}
