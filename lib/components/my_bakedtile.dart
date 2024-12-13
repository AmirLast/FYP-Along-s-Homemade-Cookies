import 'package:flutter/material.dart';
import 'package:fyp/models/bakedclass.dart';

class BakedTile extends StatelessWidget {
  final Bakeds? prod;
  final void Function()? onTap;
  final void Function()? onEdit;
  final void Function()? onDel;

  const BakedTile({
    super.key,
    required this.prod,
    required this.onTap,
    required this.onEdit,
    required this.onDel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //text product detail
          Expanded(
            child: ListTile(
              onTap: onTap,
              title: Text(
                prod!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          //const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: onEdit,
                child: const Icon(Icons.edit, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  //padding: const EdgeInsets.all(5),
                  backgroundColor: Colors.grey.shade400, // <-- Button color
                  //foregroundColor: Colors.red, // <-- Splash color
                ),
              ),
              //const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onDel,
                child: const Icon(Icons.close_rounded, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  //padding: const EdgeInsets.all(5),
                  backgroundColor: Colors.grey.shade400, // <-- Button color
                  //foregroundColor: Colors.red, // <-- Splash color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
