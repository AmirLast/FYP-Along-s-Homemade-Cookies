import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/models/bakedclass.dart';

class MyPreviewProdTile extends StatefulWidget {
  final List<Bakeds?> bakeds;
  final String category;
  const MyPreviewProdTile({
    super.key,
    required this.bakeds,
    required this.category,
  });

  @override
  State<MyPreviewProdTile> createState() => _MyPreviewProdTileState();
}

class _MyPreviewProdTileState extends State<MyPreviewProdTile> {
  late List<Bakeds?> currentBakeds = widget.bakeds.where((b) => b!.category == widget.category).toList();
  final obj = MyCachednetworkimage();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: currentBakeds.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        bool isAvailable = currentBakeds[index]!.quantity > 0;
        return Column(
          children: [
            Container(height: 2, color: Colors.black),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: const Color(0xffc1ff72).withValues(alpha: 0.5),
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    //text product detail
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentBakeds[index]!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: isAvailable ? Colors.black : Colors.black.withValues(alpha: 0.4),
                            ),
                          ),
                          Text(
                            'RM' + currentBakeds[index]!.price.toStringAsFixed(2),
                            style: TextStyle(
                              color: isAvailable ? Colors.black : Colors.black.withValues(alpha: 0.4),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentBakeds[index]!.description,
                            style: TextStyle(
                              color: isAvailable ? Colors.black : Colors.black.withValues(alpha: 0.4),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Available Product: " + currentBakeds[index]!.quantity.toString(),
                            style: TextStyle(
                              color: isAvailable ? Colors.black : Colors.black.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // prod image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: SizedBox(
                        width: 160,
                        height: 160,
                        child: Opacity(
                          opacity: isAvailable ? 1 : 0.5,
                          child: obj.showImage(currentBakeds[index]!.url),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 2, color: Colors.black),

            //divider at the bottom screen
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
