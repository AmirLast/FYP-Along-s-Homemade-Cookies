import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_bakedtile.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/owner/addproduct.dart';
import 'package:fyp/pages/owner/editproduct.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

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
    List<Bakeds?> categoryMenu = baked.where((b) => b!.category == catName).toList();
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
                  collapsedBackgroundColor: Colors.grey.shade400,
                  backgroundColor: Colors.white,
                  title: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      catName,
                      style: const TextStyle(
                        color: Colors.black,
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
                          onTap: () {},
                          onEdit: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              //calling ProdPage while sending prod values
                              builder: (context) => EditProdPage(
                                prod: categoryMenu[index],
                                category: catName,
                                isSaved: false,
                              ),
                            ),
                          ), //pergi page baru (cam add category) + access data guna func update cam kat addcategory
                          onDel: () {
                            //confirm pop up
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                                      content: Text(
                                        "Do you want to delete product named '" + categoryMenu[index]!.name + "'?",
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              iconSize: 50,
                                              color: Colors.green,
                                              onPressed: () async {
                                                User? user = AuthService().getCurrentUser();
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user!.uid)
                                                    .collection(catName)
                                                    .where('name', isEqualTo: categoryMenu[index]!.name)
                                                    .get()
                                                    .then(
                                                  (querySnapshot) {
                                                    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                      documentSnapshot.reference.delete();
                                                    }
                                                  },
                                                );
                                                // loading circle-------------------------
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const Center(
                                                      child: CircularProgressIndicator(color: Colors.black),
                                                    );
                                                  },
                                                );
                                                await Future.delayed(const Duration(seconds: 2), () {
                                                  Navigator.pop(context);
                                                  //pop loading circle---------
                                                  //refresh new menu page
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const MenuPage(),
                                                    ),
                                                  );
                                                });
                                              },
                                              icon: const Icon(Icons.check_circle),
                                            ),
                                            IconButton(
                                                iconSize: 50,
                                                color: Colors.red,
                                                onPressed: () => Navigator.pop(context),
                                                icon: const Icon(Icons.cancel)),
                                          ],
                                        )
                                      ],
                                    ));
                          },
                        );
                      },
                    ),
                    //button add product
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          //calling AddProduct while sending prod name
                          builder: (context) => AddProduct(category: catName),
                        ),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 35,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
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
                      backgroundColor: Colors.grey.shade400,
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
                      backgroundColor: Theme.of(context).colorScheme.secondary, // <-- Button color
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
