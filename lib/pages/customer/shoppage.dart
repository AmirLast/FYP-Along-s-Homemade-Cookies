import 'package:flutter/material.dart';
import 'package:fyp/components/my_drawer.dart';
import 'package:fyp/components/my_logo.dart';
import 'package:fyp/models/bakedclass.dart';

class ShopPage extends StatefulWidget {
  final String name;
  final List<Bakeds?> bakeds;

  const ShopPage({
    super.key,
    required this.name,
    required this.bakeds,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Logo show = Logo(); //for logo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1a271),
      appBar: AppBar(
        backgroundColor: const Color(0xffB67F5F),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            widget.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
      drawer: const MyDrawer(), //default drawer);
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, //max width for current phone
          height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight, //max height for current phone
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
                    return Column(
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.5),
                          child: GestureDetector(
                            onTap: () {},
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
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                        Text(
                                          'RM' + widget.bakeds[index]!.price.toStringAsFixed(2),
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          widget.bakeds[index]!.description,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  // prod image
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundImage: NetworkImage(widget.bakeds[index]!.url),
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
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
