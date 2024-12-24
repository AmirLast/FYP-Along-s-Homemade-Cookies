import 'package:flutter/material.dart';
import 'package:fyp/models/shoppingclass.dart';
import 'package:fyp/models/userclass.dart';
import 'package:fyp/pages/all_user/profile.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Your location"),
        content: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
          child: Text(context.read<Shopping>().deliveryAddress),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Delivery Address",
            style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              //address
              GestureDetector(
                onTap: () => openLocationSearchBox(context),
                child: Consumer<Shopping>(
                  builder: (context, shopping, child) => SizedBox(
                    width: MediaQuery.of(context).size.width - 66 - 5 - 15,
                    child: Text(
                      shopping.deliveryAddress,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 5),

              //drop down menu
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(type: UserNow.usernow.type))),
                child: const Icon(
                  Icons.mode_edit_outline_rounded,
                  size: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
