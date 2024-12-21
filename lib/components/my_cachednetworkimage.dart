import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCachednetworkimage {
  showImage(String src) {
    return CachedNetworkImage(
      imageUrl: src,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xffB67F5F),
        ),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
      fit: BoxFit.cover,
    );
  }
}
