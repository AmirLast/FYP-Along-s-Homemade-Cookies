import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DownloadURL {
  //get Url of product image so it can be displayed------------------------------------------
  Future<String> downloadUrl(String name, String useruid, BuildContext context) async {
    var path = '$useruid/$name';
    try {
      await FirebaseStorage.instance.ref().child(path).getDownloadURL().then((String url) {
        return url;
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            "Product image does not exist",
            style: TextStyle(color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ),
      );
      throw Exception(e);
    }
    return "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637";
  } //Url of product image so it can be displayed------------------------------------------
}
