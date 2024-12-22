import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/models/shopclass.dart';

class ShopCard extends StatefulWidget {
  final Shops? shop;
  final void Function()? onTap;

  const ShopCard({
    super.key,
    required this.shop,
    required this.onTap,
  });

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  final obj = MyCachednetworkimage();

  int remainingProd(int total) {
    return total - 5;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Text(
                    widget.shop!.name,
                    style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.shop!.bakeds.length > 5 ? 5 : widget.shop!.bakeds.length,
                    padding: const EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 4) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: obj.showImage(widget.shop!.bakeds[index]!.url),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.grey),
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    "+" + remainingProd(widget.shop!.bakeds.length).toString(),
                                    style: TextStyle(
                                      color: Colors.black.withValues(alpha: 0.4),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: obj.showImage(widget.shop!.bakeds[index]!.url),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  ),
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: const Row(children: [
                      Text(
                        "Check Shop",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_rounded),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
