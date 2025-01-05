import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/orderclass.dart';

class ReviewPage extends StatefulWidget {
  final String shopID;
  const ReviewPage({super.key, required this.shopID});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Logo show = Logo(); //for logo
  bool isExpand = false;
  late List<Orders> reviews;

  void reorder() {
    reviews = Orders.currentOrder.orders.where((a) => a.status == "Confirm" && a.reviewID == widget.shopID).toList();
    reviews.sort((x, y) => x.dateDT.compareTo(y.dateDT));
    setState(() {});
  }

  @override
  void initState() {
    reorder();
    super.initState();
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
        title: const Center(
          child: Text(
            textAlign: TextAlign.center,
            "Reviews",
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
          decoration: show.showLogo(),
          child: Column(
            children: [
              reviews.isEmpty
                  ? const Expanded(
                      child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text("Review is empty.."),
                    ))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: reviews.length,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: Expanded(
                              child: Text(
                                reviews[index].review,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
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
