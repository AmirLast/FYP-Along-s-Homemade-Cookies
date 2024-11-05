import 'package:flutter/material.dart';
import 'package:fyp/components/my_cattile.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/owner/addcategory.dart';
import 'package:fyp/pages/owner/updatemenu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
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
        child: Icon(
          Icons.add_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddCategory())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
          width:
              MediaQuery.of(context).size.width, //max width for current phone
          height:
              MediaQuery.of(context).size.height, //max height for current phone
          //for logo transparent
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            image: DecorationImage(
              image: const AssetImage("lib/images/applogo.png"),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.surface.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              alignment: Alignment.center,
              scale: 0.5,
            ),
          ),
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
                      onDel:
                          () {}, //pop up delete confirm -> delete FBFS -> delete local data -> pushreplacement ke menupage
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
