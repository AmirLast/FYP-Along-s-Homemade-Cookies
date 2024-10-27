import 'package:flutter/material.dart';
import 'package:fyp/models/bakedclass.dart';

class ProductTile extends StatelessWidget {
  final Bakeds? prod;
  final void Function()? onTap;
  final void Function()? onEdit;
  final void Function()? onDel;

  const ProductTile({
    super.key,
    required this.prod,
    required this.onTap,
    required this.onEdit,
    required this.onDel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //text product detail
              ListTile(
                onTap: onTap,
                title: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      prod!.name,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onEdit,
                child: const Icon(Icons.edit),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondary, // <-- Button color
                  //foregroundColor: Colors.red, // <-- Splash color
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onDel,
                child: const Icon(Icons.close_rounded),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondary, // <-- Button color
                  //foregroundColor: Colors.red, // <-- Splash color
                ),
              ),

              // prod image
              /*ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  prod.imagePath,
                  height: 10,
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
