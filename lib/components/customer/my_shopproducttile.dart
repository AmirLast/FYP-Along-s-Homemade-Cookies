import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_cachednetworkimage.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/customer/prodpage.dart';

class MyProdTile extends StatefulWidget {
  final List<Bakeds?> bakeds;
  final String category;
  const MyProdTile({
    super.key,
    required this.bakeds,
    required this.category,
  });

  @override
  State<MyProdTile> createState() => _MyProdTileState();
}

class _MyProdTileState extends State<MyProdTile> {
  late List<Bakeds?> currentBakeds = widget.bakeds.where((b) => b!.category == widget.category).toList();
  final obj = MyCachednetworkimage();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: currentBakeds.length, //limit to 10 display
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        bool isAvailable = currentBakeds[index]!.quantity > 0;
        return Column(
          children: [
            Container(height: 2, color: Colors.black),
            GestureDetector(
              onTap: isAvailable
                  ? () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProdPage(prod: currentBakeds[index])));
                    }
                  : null,
              child: Container(
                color: const Color(0xffc1ff72).withValues(alpha: 0.5),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      //text product detail
                      Expanded(
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

                      const SizedBox(width: 15),

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
                          /*Image.network(
                            ,
                            opacity,
                            fit: BoxFit.fill,
                          ),*/
                        ),
                      ),
                    ],
                  ),
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
