import 'package:flutter/material.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:fyp/models/userclass.dart';

class OrderCard extends StatelessWidget {
  final Orders? order;
  final void Function()? onCancel;
  final void Function()? onCheck;

  const OrderCard({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    String type = UserNow.usernow!.type;
    String formattedDate = order!.dateString;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            type == 'buyer'
                ? Center(child: Text("Order On: " + formattedDate))
                : Center(child: Text("Order On: " + formattedDate + "\nStatus: " + order!.status)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Text(order!.order),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //cancel button
                MaterialButton(
                  onPressed: onCancel,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),

                //check status button
                MaterialButton(
                  onPressed: onCheck,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        type == 'buyer' ? order!.status : "Change Status",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
