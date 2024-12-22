import 'package:flutter/material.dart';

class Loading {
  void loading(BuildContext context) {
    showDialog(
      barrierDismissible: false, //to prevent outside click
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              return;
            }
          },
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xffB67F5F)),
          ),
        );
      },
    );
  }
}
