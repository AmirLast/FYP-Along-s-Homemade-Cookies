import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/my_scaffoldmessage.dart';

class DownloadURL {
  final MyScaffoldmessage obj = MyScaffoldmessage(); //for scaffold message
  //get Url of product image so it can be displayed------------------------------------------
  Future<String> downloadUrl(String name, String useruid, BuildContext context) async {
    var path = '$useruid/$name';
    try {
      var url = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      obj.scaffoldmessage("Product image does not exist", context);
      if (kDebugMode) {
        print(e.code.toString());
      }
      return "https://firebasestorage.googleapis.com/v0/b/fyp-along-shomemadecookies.appspot.com/o/default_item.png?alt=media&token=a6c87415-83da-4936-81dc-249ac4d89637";
    }
  } //Url of product image so it can be displayed------------------------------------------
}
