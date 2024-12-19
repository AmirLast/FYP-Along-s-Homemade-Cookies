import 'package:flutter/material.dart';
//import 'package:fyp/models/bakedclass.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  //final Bakeds? prod;
  final VoidCallback onInc;
  final VoidCallback onDec;

  const QuantitySelector({
    super.key,
    required this.quantity,
    //required this.prod,
    required this.onDec,
    required this.onInc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //decrease button
          GestureDetector(
            onTap: onDec,
            child: const Icon(
              Icons.remove,
              size: 20,
              color: Colors.black,
            ),
          ),

          //quantity counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(
                  quantity.toString(),
                ),
              ),
            ),
          ),

          //increase button
          GestureDetector(
            onTap: onInc,
            child: const Icon(
              Icons.add,
              size: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
