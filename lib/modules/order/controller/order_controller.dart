import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import '../../../config/controller/app_controller.dart';
import '../../../config/controller/map_controller.dart';
import '../../../config/helper/my_utils.dart';
import '../model/delivery_item.dart';
import '../model/task.dart';
import '../model/temp_item.dart';

class OrderController extends GetxController {
  var showFullOrder = false.obs;
  var isStatusLoaded = true.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var filterTypes = ['Todo', 'All'];
  var selectedFilterType = 'Todo'.obs;
  AppController appController = Get.find();
  RxList<Rows> ordersList = <Rows>[].obs;
  RxList<Rows> todoList = <Rows>[].obs;
  late SignatureController signatureController;
  final currentOrder = Rows.fromJson({}).obs;
  RxList<ItemData> deliveryItems = <ItemData>[].obs;
  var itemsQuantityData = <TempItem>[];
  List itemsImageData = <TempItem>[];
  var isOrderLoaded = false.obs;
  List<ItemQuantityUpdate> quantityUpdate = [];
  List<ItemImageUpdate> imageUpdate = [];
  var deliveryStatus = "0 deliveries".obs;
  late AppMapController mapController;



  selectedFilteredTypes(index) {
    selectedFilterType.value = filterTypes[index];
  }

  getFilteredType() => selectedFilterType.value;

  Map statuses = {
    3: "ToDo",
    5: "Completed",
    6: "Failed",
    8: "Arrived",
    7: "Departed",
    9: "Started"
  };

  getOrders() async {
    ordersList.value = await appController.getOrders() ?? [];
    var visitordernoMap = <int, int>{};
    for (int i = 0; i < ordersList.length; i++) {
      int? visitorderno = ordersList[i].visitorderno;
      if (visitorderno == 0) {
        visitorderno = i * 3;
        ordersList[i].visitorderno = visitorderno;
      }
      visitordernoMap[visitorderno!] = (visitordernoMap[visitorderno] ?? 0) + 1;
    }
    for (int i = 0; i < ordersList.length; i++) {
      appDebugPrint(ordersList[i].visitorderno);
      int? visitorderno = ordersList[i].visitorderno;
      if (visitordernoMap[visitorderno]! > 1) {
        visitorderno = visitorderno! + i;
        ordersList[i].visitorderno = visitorderno;
        visitordernoMap[visitorderno] =
            (visitordernoMap[visitorderno] ?? 0) + 1;
      }
    }

    ordersList.sort((a, b) => a.visitorderno!.compareTo(b.visitorderno!));
    appDebugPrint('ordersList : ${ordersList.length}');
    filteredTodosList();
  }

  filteredTodosList() {
    todoList.value = ordersList.where((order) => order.statusid == 3).toList();
    appDebugPrint('todoList ${todoList.length}');
    updateDeliveryDetails("${todoList.length} left to deliver ");
    update();
  }

  updateDeliveryDetails(value) {
    deliveryStatus.value = value;
    update();
  }

  nextOrder() {
    if (todoList.isNotEmpty) {
      if (todoList.length > 1) {
        for (var a in todoList) {
          if (a.deliveryrefno == currentOrder.value.deliveryrefno) {
            var index = todoList.indexOf(a);
            // currentOrder.value = todoList[index + 1];
            setCurrentOrder(order: todoList[index + 1]);
            updateDeliveryDetails('${todoList.length - 1} left to deliver');
            todoList.removeAt(index);
            todoList.refresh();

            update();
            break;
          }
        }
      } else {
        // currentOrder.value = todoList.last;
        setCurrentOrder(order: todoList.last);
        updateDeliveryDetails('0 left to deliver');
        todoList.removeLast();
        todoList.refresh();

        if (todoList.isEmpty) {
          // currentOrder.value = Rows.fromJson({'deliveryid': 0});
          setCurrentOrder(order: Rows.fromJson({'deliveryid': 0}));
          itemsQuantityData.clear();
          itemsImageData.clear();
          deliveryItems.clear();
          update();
          // Get.back();
        }
        return;
      }
      appDebugPrint('no orders remaining temp ');
      appDebugPrint(todoList.length);
    } else {
      appDebugPrint('no orders remaining');
      // currentOrder.value = Rows.fromJson({'deliveryid': 0});
      setCurrentOrder(order: Rows.fromJson({'deliveryid': 0}));
      itemsQuantityData.clear();
      itemsImageData.clear();
      deliveryItems.clear();
      update();
    }
  }

  reloadOrders() async {
    var temp = ordersList;
    await getOrders();
    ordersList.toList().forEach((order) {
      if (temp.contains(order)) {
        appDebugPrint("duplicate ${order.visitorderno}");
      } else {
        temp.add(order);
      }
    });
    appDebugPrint("duplicate ${temp.length}");
  }

  addQuantity({required int itemId, required int qty}) {
    if (quantityUpdate.isEmpty) {
      quantityUpdate.add(ItemQuantityUpdate(itemid: itemId, qty: qty));
      appDebugPrint('one');
      return;
    }

    bool itemExists = quantityUpdate.any((item) => item.itemid == itemId);
    if (itemExists) {
      int index = quantityUpdate.indexWhere((item) => item.itemid == itemId);
      quantityUpdate[index].qty = qty;
    } else {
      quantityUpdate.add(ItemQuantityUpdate(itemid: itemId, qty: qty));
    }

    appDebugPrint('quantityUpdate');
    appDebugPrint(quantityUpdate.length);
    appDebugPrint('temid: $itemId, qty: $qty');
  }

  setCurrentOrder({order, controller}) async {
    currentOrder.value = order;
    await appController.getDeliveryItems(
        deliveryId: currentOrder.value.deliveryid!);
    appDebugPrint("current order ${currentOrder.toJson()}");
    update();
  }

  reOrderVisit(int i, int j) {}

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.closeEndDrawer();
  }

  @override
  void onInit() {
    super.onInit();
    mapController = Get.put(AppMapController());
    getOrders();
  }
}
