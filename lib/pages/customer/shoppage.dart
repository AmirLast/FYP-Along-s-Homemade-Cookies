import 'package:flutter/material.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/customer/cartpage.dart';
import 'package:fyp/pages/customer/prodpage.dart';

class ShopPage extends StatefulWidget {
  final String name; //shop name
  final List<Bakeds?> bakeds; //the shop bakeds with categories
  final String id; //owner user id

  const ShopPage({
    super.key,
    required this.name,
    required this.bakeds,
    required this.id,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Logo show = Logo(); //for logo

  @override
  void initState() {
    super.initState();
    UserNow.usernow?.currentdir = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.name + " Shop",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
          decoration: show.showLogo(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Sort by"), Icon(Icons.arrow_drop_down_sharp)],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.bakeds.length, //limit to 10 display
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    bool isAvailable = widget.bakeds[index]!.quantity > 0;
                    return Column(
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.5),
                          child: GestureDetector(
                            onTap: isAvailable
                                ? () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProdPage(prod: widget.bakeds[index])));
                                  }
                                : null,
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
                                          widget.bakeds[index]!.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: isAvailable ? Colors.black : Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                        Text(
                                          'RM' + widget.bakeds[index]!.price.toStringAsFixed(2),
                                          style: TextStyle(
                                            color: isAvailable ? Colors.black : Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          widget.bakeds[index]!.description,
                                          style: TextStyle(
                                            color: isAvailable ? Colors.black : Colors.black.withOpacity(0.4),
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Available Product: " + widget.bakeds[index]!.quantity.toString(),
                                          style: TextStyle(
                                            color: isAvailable ? Colors.black : Colors.black.withOpacity(0.4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  // prod image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.network(
                                      widget.bakeds[index]!.url,
                                      opacity: isAvailable ? null : const AlwaysStoppedAnimation(.5),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //divider at the bottom screen
                        const Divider(
                          color: Colors.black,
                          endIndent: 25,
                          indent: 25,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
