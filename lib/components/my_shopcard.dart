import 'package:flutter/material.dart';
import 'package:fyp/models/shopclass.dart';

class ShopCard extends StatelessWidget {
  final Shops? shop;
  final void Function()? onTap;

  const ShopCard({
    super.key,
    required this.shop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //text product detail
          Expanded(
            child: ListTile(
              /*
              leading: SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 10,
                height: MediaQuery.of(context).size.width / 3 - 10,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: Image.network(shop!.bakeds[0]!.url),
                ),
              ),*/
              title: Center(
                child: Text(
                  shop!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
