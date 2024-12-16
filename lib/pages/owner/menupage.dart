import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_categorytile.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/addcategory.dart';
import 'package:fyp/pages/owner/editcategory.dart';
import 'package:fyp/pages/owner/updatemenu.dart';
import 'package:fyp/services/auth/auth_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  final Logo show = Logo(); //for logo
  List cat = UserNow.usernow!.categories;
  List<Bakeds?> menus = [];
  final obj = UpdateMenuData();

  Future<void> updateMenu() async {
    //update menu data in local memory
    await obj.updatemenudata("").then((temp) {
      setState(() {
        menus = temp;
      });
    });
  }

  @override
  void initState() {
    updateMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the add button
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_rounded,
          color: Colors.black,
          size: 50,
        ),
        backgroundColor: Colors.grey.shade400,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCategory())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Manage Menu",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(), //default drawer
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height, //max height for current phone
          decoration: show.showLogo(), //for logo
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: cat.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final String catName = cat[index].toString();
                      //return product tile UI
                      return CategoryTile(
                        catName: catName,
                        baked: menus,
                        onEdit: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            //calling ProdPage while sending prod values
                            builder: (context) => EditCategoryPage(
                              category: catName,
                            ),
                          ),
                        ), //pop up confirm -> pergi page baru (cam add category) -> update (cam kat addcategory.dart) -> back to menu
                        //for collection: read the collection data into local data buffer(array) -> delete prev collection -> insert buffer into new collection name
                        onDel: () {
                          //confirm pop up
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      "Do you want to delete category named '" + catName + "'? All product will be deleted too.",
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
                                              //delete data from firebase categories value
                                              await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                                                'categories': FieldValue.arrayRemove([catName])
                                              });
                                              //delete data from firebase collection
                                              List<Bakeds?> documents = [];
                                              await obj.updatemenudata(catName).then((temp) async {
                                                documents = temp;
                                                int i = 0;
                                                int j = documents.length;
                                                //if theres no product, no document to be delete, this for loop won't be bothered
                                                for (i; i < j; i++) {
                                                  await FirebaseFirestore.instance
                                                      .collection('users')
                                                      .doc(user.uid)
                                                      .collection(catName)
                                                      .doc(documents[i]?.name)
                                                      .delete();
                                                }
                                              });

                                              //delete data from local class
                                              UserNow.usernow?.categories.remove(catName);

                                              // loading circle-------------------------
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const Center(
                                                    child: CircularProgressIndicator(color: Color(0xffB67F5F)),
                                                  );
                                                },
                                              );
                                              Future.delayed(const Duration(seconds: 2), () {
                                                Navigator.pop(context);
                                                //pop loading circle---------
                                                //refresh new menu page
                                                Navigator.pop(context);
                                                updateMenu();
                                                /*Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const MenuPage(),
                                                  ),
                                                );*/
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
                        }, //pop up delete confirm -> delete FBFS -> delete local data -> pushreplacement ke menupage
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
