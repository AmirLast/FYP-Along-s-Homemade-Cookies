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
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.shade400,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //text product detail
            Expanded(
              child: ListTile(
                onTap: onTap,
                title: Text(
                  prod!.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                color: Colors.grey.shade400,
                child: const Icon(Icons.edit, size: 20, color: Colors.black),
              ),
            ),
            GestureDetector(
              onTap: onDel,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                ),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: const Icon(Icons.close_rounded, size: 25, color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
