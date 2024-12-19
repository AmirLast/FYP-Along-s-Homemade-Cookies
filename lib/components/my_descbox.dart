import 'package:flutter/material.dart';

class MyDescBox extends StatelessWidget {
  const MyDescBox({super.key});

  @override
  Widget build(BuildContext context) {
    //text style
    var myPrimaryTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary);
    var mySecondaryTextStyle = TextStyle(color: Theme.of(context).colorScheme.primary);

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //delivery fee
            Column(
              children: [
                Text(
                  "RM2.00",
                  style: myPrimaryTextStyle,
                ),
                Text(
                  "Delivery fee",
                  style: mySecondaryTextStyle,
                ),
              ],
            ),
            //delivery time
            Column(
              children: [
                Text(
                  "15~30 min",
                  style: myPrimaryTextStyle,
                ),
                Text(
                  "Delivery time",
                  style: mySecondaryTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
