import 'package:flutter/material.dart';
import 'package:fyp/models/baked.dart';

class ProdTile extends StatelessWidget {
  final Baked prod;
  final void Function()? onTap;

  const ProdTile({
    super.key,
    required this.prod,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                //text product detail
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prod.name),
                      Text(
                        'RM' + prod.price.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        prod.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 15),

                // prod image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    prod.imagePath,
                    height: 120,
                  ),
                ),
              ],
            ),
          ),
        ),

        //divider at the bottom screen
        Divider(
          color: Theme.of(context).colorScheme.primary,
          endIndent: 25,
          indent: 25,
        ),
      ],
    );
  }
}
