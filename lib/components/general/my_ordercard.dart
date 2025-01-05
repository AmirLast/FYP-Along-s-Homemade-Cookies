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
  final void Function()? onReceive;

  const OrderCard({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onComplete,
    required this.onInfo,
    required this.onPin,
    required this.onReceive,
    required this.title,
    required this.index,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Widget theCard(BuildContext context, String formattedDate, String status, bool isOwner, bool canCancel, int dayPassed) {
    bool isPinnable = status == "Pin" || status == "Unpin" || status == "Pending";
    bool isComplete = status == "Complete";
    bool isConfirm = status == "Confirm"; //to disable confirm receive
    Color? textColor = isPinnable ? Colors.black : Colors.black.withValues(alpha: 0.4);
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
                                Center(
                                    child: Text(
                                  "Order On: $formattedDate",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )),
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
                          visible: widget.order!.status == "Pin" && UserNow.usernow.type == "seller",
                          child: const Icon(
                            Icons.star,
                            color: Colors.amber,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Status: " + status,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Visibility(visible: isPinnable || isComplete, child: const SizedBox(width: 15)),
                            Visibility(
                              visible: isPinnable || isComplete,
                              child: Text(
                                dayPassed.toString() + " days passed",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: !isPinnable,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    textAlign: TextAlign.center,
                                    widget.order!.status == "Cancel" ? "Cancelled for" : "Completed on",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                    widget.order!.reasonOrdate,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.all(8.0),
                              width: 270,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                widget.order!.status == "Cancel"
                                    ? "Cancelled for: ${widget.order!.reasonOrdate}"
                                    : "Completed On: ${widget.order!.reasonOrdate}",
                                style: const TextStyle(color: Colors.black, overflow: TextOverflow.ellipsis),
                                textAlign: TextAlign.left,
                              ),
                            ),
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
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      widget.order!.cartitems[index].values.elementAt(2).toString(), //2 is name
                                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.order!.cartitems[index].values.elementAt(0).toString(), //1 is quantity
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
                  onPressed: isPinnable ? widget.onComplete : null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: isPinnable ? Colors.lightGreenAccent : Colors.lightGreenAccent.withValues(alpha: 0.4),
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

              //on receive button
              Visibility(
                visible: !isOwner && (isComplete || isConfirm),
                child: MaterialButton(
                  onPressed: isComplete ? widget.onReceive : null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: !isComplete ? Colors.white.withValues(alpha: 0.4) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        canCancel ? "Confirm Receive" : "Write Review",
                        style: TextStyle(
                          color: !isComplete ? Colors.black.withValues(alpha: 0.4) : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //cancel button
              Visibility(
                visible: !(!isOwner && (isComplete || isConfirm)),
                child: MaterialButton(
                  onPressed: isPinnable && canCancel ? widget.onCancel : null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: isPinnable && canCancel ? Colors.red : Colors.red.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: isPinnable && canCancel ? Colors.black : Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //pin button
              Visibility(
                visible: isOwner,
                child: MaterialButton(
                  onPressed: isPinnable ? widget.onPin : null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: isPinnable ? Colors.deepPurple : Colors.deepPurple.withValues(alpha: 0.4),
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

  Widget theColumn(BuildContext context, String formattedDate, String status, bool isOwner, bool canCancel, int dayPassed) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(90, 10, 90, 0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        theCard(context, formattedDate, status, isOwner, canCancel, dayPassed),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOwner = UserNow.usernow.type == "seller";
    String formattedDate = widget.order!.dateString;
    String status = widget.order!.status == "Pin" ? "Pending" : widget.order!.status;
    DateTime statusTime;
    if (status == "Pending") {
      statusTime = widget.order!.dateDT;
    } else {
      statusTime = DateTime.parse(widget.order!.onchange);
    }
    Duration dayPassed = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .difference(DateTime(statusTime.year, statusTime.month, statusTime.day));
    bool canCancel = dayPassed.inDays < 3;

    return widget.index != 0
        ? Column(
            children: [
              theCard(context, formattedDate, status, isOwner, canCancel, dayPassed.inDays),
            ],
          )
        : theColumn(context, formattedDate, status, isOwner, canCancel, dayPassed.inDays);
  }
}
