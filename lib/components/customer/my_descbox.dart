import 'package:flutter/material.dart';

class MyDescBox extends StatelessWidget {
  const MyDescBox({super.key});

  @override
  Widget build(BuildContext context) {
    //text style
    var myPrimaryTextStyle = const TextStyle(color: Colors.white70);
    var mySecondaryTextStyle = const TextStyle(color: Colors.black);

    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.brown[400],
        border: Border.all(color: Colors.brown.shade900),
        borderRadius: BorderRadius.circular(8),
      ),
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
                "3~6 days",
                style: myPrimaryTextStyle,
              ),
              Text(
                "Delivery day",
                style: mySecondaryTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
