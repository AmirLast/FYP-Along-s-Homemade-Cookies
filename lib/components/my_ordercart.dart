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

    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            type == 'buyer'
                ? Text("Order On: " + order!.date)
                : Row(
                    children: [Text("Order On: " + order!.date), Text("Status: " + order!.status)],
                  ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Text(order!.order),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //cancel button
                MaterialButton(
                  onPressed: onCancel,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                //check status button
                MaterialButton(
                  onPressed: onCheck,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        type == 'buyer' ? order!.status : "Change Status",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
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
