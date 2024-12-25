class Orders {
  String dateString;
  DateTime dateDT;
  String order;
  String status;
  List<Orders> orders = [];
  List cartitems;
  String id;
  String reasonOrdate = "";
  Orders({
    required this.id,
    required this.dateString,
    required this.dateDT,
    required this.order,
    required this.status,
    required this.cartitems,
  });
  static Orders currentOrder = Orders(
    id: "",
    dateString: "",
    dateDT: DateTime.now(),
    order: "",
    status: "",
    cartitems: [],
  );
}
