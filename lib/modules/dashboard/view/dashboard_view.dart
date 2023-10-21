

import 'package:flutter/material.dart';

import '../../../Widget/driver_drawer.dart';
import '../../../config/responsive/size_config.dart';
import '../../../config/theme/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appbackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
            color: AppColors.textColor
        ),
        title: Text('Dashboard', style: TextStyle(color: AppColors.textColor),),
        centerTitle: true,
      ),
      body: SizedBox(
        height: kHeight,
        width: kWidth,
        child: Column(

          children: [
            Container(
              height: kHeight * 0.2,
              width: kWidth,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('user name', style: TextStyle(color: AppColors.textColor)),
                  setHeight(20),
                  Text('user name', style: TextStyle(color: AppColors.textColor)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // height: kHeight * 0.7,
                // width: kWidth,
                // margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: AppColors.alterColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(setHeightValue(50)),
                        topLeft: Radius.circular(setHeightValue(50)))),
              ),
            )
          ],
        ),
      ),
      drawer: DriverDrawer(),
    );
  }
}
