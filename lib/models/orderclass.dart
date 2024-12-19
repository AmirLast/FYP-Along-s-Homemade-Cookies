class Orders {
  String date;
  String order;
  String status;
  Orders({
    required this.date,
    required this.order,
    required this.status,
  });
  static Orders? currentOrder;
}
