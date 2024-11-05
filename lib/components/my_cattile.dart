import 'package:flutter/material.dart';
import 'package:fyp/components/my_bakedtile.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/owner/addproduct.dart';

class CatTile extends StatelessWidget {
  //final Baked prod;
  final String catName;
  final void Function()? onEdit;
  final void Function()? onDel;
  final List<Bakeds?> baked;

  const CatTile({
    super.key,
    required this.catName,
    required this.onEdit,
    required this.onDel,
    required this.baked,
  });

  @override
  Widget build(BuildContext context) {
    List<Bakeds?> categoryMenu =
        baked.where((b) => b!.category == catName).toList();
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 30),
              Expanded(
                child: ExpansionTile(
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  collapsedBackgroundColor:
                      Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  title: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      catName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryMenu.length,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          prod: categoryMenu[index],
                          onTap: () {}, //pergi prod page cam kat mitch
                          //alter part: nak refresh kat mana? lepas update/delete
                          //access data guna categoryMenu[index] as key different
                          onEdit:
                              () {}, //pergi page baru (cam add category) + access data guna func update cam kat addcategory
                          onDel:
                              () {}, //pop up delete confirm + access data guna func delete
                          /*=> Navigator.push(
                    context,
                    MaterialPageRoute(
                      //calling ProdPage while sending prod values
                      builder: (context) => ProdPage(prod: prod),
                    ),
                                      ),*/
                        );
                      },
                    ),
                    //button add product
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          //calling AddProduct while sending prod name
                          builder: (context) => AddProduct(prod: catName),
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 35,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary, // <-- Button color
                        //foregroundColor: Colors.red, // <-- Splash color
                      ),
                    ),
                  ], //letak list baked by category
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: onEdit,
                    child: const Icon(Icons.edit),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      //foregroundColor: Colors.red, // <-- Splash color
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: onDel,
                    child: const Icon(Icons.close_rounded),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary, // <-- Button color
                      //foregroundColor: Colors.red, // <-- Splash color
                    ),
                  ),
                ],
              ),
            ],
          ),

          //divider at the bottom screen
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
