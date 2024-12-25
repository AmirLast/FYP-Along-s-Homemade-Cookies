import 'package:flutter/material.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:fyp/models/userclass.dart';

class OrderCard extends StatefulWidget {
  final Orders? order;
  final String title;
  final int index;
  final void Function()? onCancel;
  final void Function()? onComplete;
  final void Function()? onInfo;
  final void Function()? onPin;

  const OrderCard({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onComplete,
    required this.onInfo,
    required this.onPin,
    required this.title,
    required this.index,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Widget theCard(BuildContext context, String formattedDate, String status, bool isOwner) {
    bool isEnabled = !(status == "Cancel" || status == "Complete");
    Color? textColor = isEnabled ? Colors.black : Colors.black.withValues(alpha: 0.4);
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        content: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text("Order On: $formattedDate")),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(18),
                                  child: Text(widget.order!.order),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: Column(
                      children: [
                        Visibility(
                          visible: widget.order!.status == "Pin" && UserNow.usernow.type == "owner",
                          child: const Icon(
                            Icons.star,
                            color: Colors.amber,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Status: " + status,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Text("Order On: $formattedDate"),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.order!.cartitems.length,
                          primary: false,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    widget.order!.cartitems[index].keys.first,
                                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.order!.cartitems[index].values.first.toString(),
                                    style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            "Click to see details",
                            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //complete button
              Visibility(
                visible: isOwner,
                child: MaterialButton(
                  onPressed: !isEnabled ? null : widget.onComplete,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: isEnabled ? Colors.lightGreenAccent : Colors.lightGreenAccent.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Complete",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //cancel button
              MaterialButton(
                onPressed: !isEnabled ? null : widget.onCancel,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    color: !isEnabled ? Colors.red.withValues(alpha: 0.4) : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),

              //pin button
              Visibility(
                visible: isOwner,
                child: MaterialButton(
                  onPressed: !isEnabled ? null : widget.onPin,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: isEnabled ? Colors.deepPurple : Colors.deepPurple.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        widget.order!.status == "Pin" ? "Unpin" : "Pin",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //delivery info button
              Visibility(
                visible: !isOwner,
                child: MaterialButton(
                  onPressed: widget.onInfo,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Delivery Info",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget theColumn(BuildContext context, String formattedDate, String status, bool isOwner) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 10, 90, 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                  child: Text(
                widget.title,
                style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
        theCard(context, formattedDate, status, isOwner),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOwner = UserNow.usernow.type == "owner";
    String formattedDate = widget.order!.dateString;
    String status = widget.order!.status == "Pin" ? "Pending" : widget.order!.status;

    return widget.index != 0
        ? Column(
            children: [
              theCard(context, formattedDate, status, isOwner),
            ],
          )
        : theColumn(context, formattedDate, status, isOwner);
  }
}
