class Orders {
  String dateString;
  DateTime dateDT;
  String order;
  String status;
  Orders({
    required this.dateString,
    required this.dateDT,
    required this.order,
    required this.status,
  });
  static Orders? currentOrder;
}
