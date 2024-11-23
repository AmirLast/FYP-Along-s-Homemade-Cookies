import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_cattile.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/addcategory.dart';
import 'package:fyp/pages/owner/updatemenu.dart';
import 'package:fyp/services/auth/auth_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  //for logo
  final Logo show = Logo();
  List cat = UserNow.usernow!.categories;
  List<Bakeds?> menus = [];

  Future<void> updateMenu() async {
    //update menu data in local memory
    final obj = UpdateMenuData();
    menus = await obj.updatemenudata();
    setState(() {});
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
          //for logo transparent
          decoration: show.showLogo(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: cat.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    //get individual food one by one from list categoryMenu made
                    //for now try category dulu; baru belajar listview
                    //final prod = categoryMenu[index];
                    final String catName = cat[index].toString();
                    //return product tile UI
                    return CatTile(
                      catName: catName,
                      baked: menus,
                      //alter part: nak refresh kat mana? lepas update/delete
                      //access data guna catname as key different
                      onEdit:
                          () {}, //pop up confirm -> pergi page baru (cam add category) -> update (cam kat addcategory.dart) -> back to menu
                      //for collection: read the collection data into local data buffer(array) -> delete prev collection -> insert buffer into new collection name
                      onDel: () {
                        //confirm pop up
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Text(
                                    "Do you want to delete category named '" + catName + "'?",
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
                                            await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                                              'categories': FieldValue.arrayRemove([catName])
                                            });

                                            // loading circle-------------------------
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child: CircularProgressIndicator(color: Colors.black),
                                                );
                                              },
                                            );
                                            Future.delayed(const Duration(seconds: 2), () {
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
                      }, //pop up delete confirm -> delete FBFS -> delete local data -> pushreplacement ke menupage
                      //for collection: delete prev collection
                    );
                  },
                ),
              ),
              //letak list of menu by category
              //buat updatemenu macam updateuser
              /*
              List<Widget> getProdInThisCategory(List<Baked> fullMenu) {
                return BakedCategory.values.map((category) {
                  //category is enum in baked.dart;
                  //kita kene guna usernow.categories into enum?
            
                  //get category menu only the one specified which relate to category variable
                  List<Baked> categoryMenu = fullMenu.where((baked) => baked.category == category).toList();
            
            
                  //bawah ni cuba guna untuk children dalam cattile.dart
            
                  //create ListView
                  return ListView.builder(
                    itemCount: categoryMenu.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      //get individual food one by one from list categoryMenu made
                      final prod = categoryMenu[index];
            
                      //return product tile UI
                      return ProdTile(
                        prod: prod,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            //calling ProdPage while sending prod values
                            builder: (context) => ProdPage(prod: prod),
                          ),
                        ),
                      );
                    },
                  );
                }).toList();
              }
              */
              //else
              //tunjuk big + icon to add new menu
              //+ icon => addmenupage
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
