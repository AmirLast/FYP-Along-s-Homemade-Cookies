import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/general/my_scaffoldmessage.dart';
import 'package:fyp/images/assets.dart';

class DownloadURL {
  final MyScaffoldmessage obj = MyScaffoldmessage(); //for scaffold message
  //get Url of product image so it can be displayed------------------------------------------
  Future<String> downloadUrl(String path, BuildContext context) async {
    try {
      var url = await FirebaseStorage.instance.ref().child(path).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      obj.scaffoldmessage("Product image does not exist", context);
      if (kDebugMode) {
        print(e.code.toString());
      }
      return defItem;
    }
  } //Url of product image so it can be displayed------------------------------------------
}
