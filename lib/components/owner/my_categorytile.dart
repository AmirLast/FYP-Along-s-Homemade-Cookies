import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/owner/my_bakedtile.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/pages/owner/addproduct.dart';
import 'package:fyp/pages/owner/editproduct.dart';
import 'package:fyp/pages/owner/menupage.dart';
import 'package:fyp/services/auth/auth_service.dart';

class CategoryTile extends StatefulWidget {
  final String catName;
  final void Function()? onEdit;
  final void Function()? onDel;
  final List<Bakeds?> baked;

  const CategoryTile({
    super.key,
    required this.catName,
    required this.onEdit,
    required this.onDel,
    required this.baked,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool isExpand = false;
  final MyScaffoldmessage obj = MyScaffoldmessage(); //for scaffold message
  final load = Loading();
  @override
  Widget build(BuildContext context) {
    List<Bakeds?> categoryMenu = widget.baked.where((b) => b!.category == widget.catName).toList();
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
              const SizedBox(width: 15),
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
                  title: Row(
                    children: [
                      const SizedBox(width: 15),
                      Text(
                        textAlign: TextAlign.center,
                        widget.catName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: widget.onEdit,
                        child: const Icon(Icons.edit, size: 20, color: Colors.black),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: widget.onDel,
                        child: const Icon(Icons.close_rounded, size: 25, color: Colors.black),
                      ),
                    ],
                  ),
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpand = value;
                    });
                  },
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryMenu.length,
                          primary: false,
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          itemBuilder: (context, index) {
                            return BakedTile(
                              prod: categoryMenu[index],
                              onTap: () {},
                              onEdit: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //calling ProdPage while sending prod values
                                  builder: (context) => EditProdPage(
                                    prod: categoryMenu[index],
                                    category: widget.catName,
                                  ),
                                ),
                              ), //pergi page baru (cam add category) + access data guna func update cam kat addcategory
                              onDel: () {
                                //confirm pop up
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
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
                                                    // loading circle-------------------------
                                                    load.loading(context);
                                                    //--------------------------------------

                                                    User? user = AuthService().getCurrentUser();

                                                    //delete product in collection in fbfs
                                                    await FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(user!.uid)
                                                        .collection(widget.catName)
                                                        .where('name', isEqualTo: categoryMenu[index]!.name)
                                                        .get()
                                                        .then(
                                                      (querySnapshot) async {
                                                        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                          documentSnapshot.reference.delete();
                                                          //only delete pic if imagepath is not null
                                                          if (categoryMenu[index]!.imagePath != "") {
                                                            //delete picture in storage
                                                            await FirebaseStorage.instance
                                                                .ref()
                                                                .child(categoryMenu[index]!.imagePath)
                                                                .delete();
                                                          }
                                                        }
                                                      },
                                                    ).then((onValue) {
                                                      obj.scaffoldmessage("Product Deleted", context);
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                //calling AddProduct while sending prod name
                                builder: (context) => AddProduct(category: widget.catName),
                              ),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              size: 35,
                              color: Colors.black,
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.grey.shade400, // <-- Button color
                              //foregroundColor: Colors.red, // <-- Splash color
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ], //letak list baked by category
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),

          //divider at the bottom screen
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
