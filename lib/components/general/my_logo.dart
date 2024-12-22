import 'package:flutter/cupertino.dart';

class Logo {
  showLogo() {
    return BoxDecoration(
      color: const Color(0xffd1a271),
      image: DecorationImage(
        image: const AssetImage("lib/images/applogo.png"),
        colorFilter: ColorFilter.mode(
          const Color(0xffd1a271).withValues(alpha: 0.2),
          BlendMode.dstATop,
        ),
        alignment: Alignment.center,
        scale: 1.65,
      ),
    );
  }
}
