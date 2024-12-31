class Orders {
  String dateString; //order placed but in string
  DateTime dateDT; //order placed time
  String order; //receipt
  String status;
  List<Orders> orders = [];
  List cartitems;
  String id; //the user document id
  String reasonOrdate = ""; //reason or date if complete or cancel
  String review = ""; //review string
  String reviewID = ""; //order's document id for this review
  String onchange = ""; //date of status changed
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
  void empty() {
    Orders.currentOrder = Orders(
      id: "",
      dateString: "",
      dateDT: DateTime.now(),
      order: "",
      status: "",
      cartitems: [],
    );
    Orders.currentOrder.orders.clear();
    Orders.currentOrder.reasonOrdate = "";
    Orders.currentOrder.review = "";
    Orders.currentOrder.reviewID = "";
    Orders.currentOrder.onchange = "";
  }
}
