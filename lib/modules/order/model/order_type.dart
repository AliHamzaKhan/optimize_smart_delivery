enum OrderType {
  ToDo('ToDo'),
  Completed('Completed'),
  Failed('Failed'),
  Arrived('Arrived'),
  Departed('Departed'),
  Started('Started');

  const OrderType(this.value);

  final String value;
}

String getNameByStatusNum(number) {
  switch (number) {
    case 3:
      return OrderType.ToDo.value;
    case 5:
      return OrderType.Completed.value;
    case 6:
      return OrderType.Failed.value;
    case 8:
      return OrderType.Arrived.value;
    case 7:
      return OrderType.Departed.value;
    case 9:
      return OrderType.Started.value;
    default:
      return OrderType.ToDo.value;
  }
}

int getStatusIndex(OrderType orderType) {
  switch (orderType) {
    case OrderType.ToDo:
      return 3;
    case OrderType.Completed:
      return 5;
    case OrderType.Failed:
      return 6;
    case OrderType.Arrived:
      return 8;
    case OrderType.Departed:
      return 7;
    case OrderType.Started:
      return 9;
    default:
      return 3;
  }
}

Map statuses = {
  3: "ToDo",
  5: "Completed",
  6: "Failed",
  8: "Arrived",
  7: "Departed",
  9: "Started"
};
