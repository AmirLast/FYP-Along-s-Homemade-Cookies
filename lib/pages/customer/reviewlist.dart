import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_logo.dart';
import 'package:fyp/models/orderclass.dart';
import 'package:fyp/models/userclass.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Logo show = Logo(); //for logo
  bool isExpand = false;
  late List<Orders> reviews;

  void reorder() {
    reviews = Orders.currentOrder.orders.where((a) => a.status == "Confirm" && a.reviewID == UserNow.usernow.currentdir).toList();
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
      body: Container(
        width: MediaQuery.of(context).size.width, //max width for current phone
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight + 19, //max height for current phone
        decoration: show.showLogo(),
        child: Column(
          children: [
            reviews.isEmpty
                ? const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text("Review is empty.."),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: reviews.length,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  reviews[index].review,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
