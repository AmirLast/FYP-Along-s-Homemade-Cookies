import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/owner/my_categorytile.dart';
import 'package:fyp/components/general/my_loading.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/functions/showloading.dart';
import 'package:fyp/pages/owner/addcategory.dart';
import 'package:fyp/pages/owner/editcategory.dart';
import 'package:fyp/pages/owner/functions/updatemenu.dart';
import 'package:fyp/pages/owner/previewshop.dart';
import 'package:fyp/services/auth_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  final Logo show = Logo(); //for logo
  List cat = UserNow.usernow.categories;
  List<Bakeds?> menus = [];
  final obj = UpdateMenuData();
  final load = Loading();
  final gotoNext = Showloading();

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Manage Menu",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.more_vert,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(), //for logo
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              MaterialButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.remove_red_eye_rounded, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Preview Shop Page'),
                    ],
                  ),
                ),
                onPressed: () {
                  gotoNext.showloading(
                    UserNow.usernow.user!.uid,
                    (context) => PreviewShop(id: UserNow.usernow.user!.uid),
                    null,
                    "menus",
                    context,
                  );
                },
              ),
              Expanded(
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
                      ),
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
                                            // loading circle-------------------------
                                            load.loading(context);
                                            //--------------------------------------

                                            User? user = AuthService().getCurrentUser(); //for doc name in fbfs

                                            //delete data from local class
                                            UserNow.usernow.categories.remove(catName);

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
                                                //delete product document in collection
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.uid)
                                                    .collection(catName)
                                                    .where('name', isEqualTo: documents[i]!.name)
                                                    .get()
                                                    .then(
                                                  (querySnapshot) async {
                                                    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
                                                      //delete document in collection of category
                                                      documentSnapshot.reference.delete();
                                                      //only delete if not default value
                                                      if (documents[i]!.imagePath != "") {
                                                        //delete picture in storage
                                                        await FirebaseStorage.instance.ref().child(documents[i]!.imagePath).delete();
                                                      }
                                                    }
                                                  },
                                                );
                                              }
                                            }).then((onValue) {
                                              Navigator.pop(context);
                                              //pop loading circle---------
                                              //refresh new menu page
                                              Navigator.pop(context);
                                              updateMenu();
                                            });
                                          },
                                          icon: const Icon(Icons.check_circle),
                                        ),
                                        IconButton(
                                          iconSize: 50,
                                          color: Colors.red,
                                          onPressed: () => Navigator.pop(context),
                                          icon: const Icon(Icons.cancel),
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                      },
                    );
                  },
                ),
              ),
              Visibility(visible: cat.isEmpty, child: const Spacer()),
              Visibility(
                visible: cat.isEmpty,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.only(left: 85),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, color: Colors.black, size: 17),
                          SizedBox(width: 15),
                          Text("click this to add category", style: TextStyle(color: Colors.black, fontSize: 17)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(visible: cat.isEmpty, child: const SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
