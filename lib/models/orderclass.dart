class Orders {
  String dateString;
  DateTime dateDT;
  String order;
  String status;
  List<Orders> orders = [];
  Orders({
    required this.dateString,
    required this.dateDT,
    required this.order,
    required this.status,
  });
  static Orders currentOrder = Orders(
    dateString: "",
    dateDT: DateTime.now(),
    order: "",
    status: "",
  );
}
