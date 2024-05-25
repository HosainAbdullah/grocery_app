import 'package:flutter/material.dart';

class ResponsiveSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double defaultSize = getScreenWidth(20.0);
  static late Orientation orientation;

  void init({required BuildContext context}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static EdgeInsets defaultPadding({double size = 16}) {
    return EdgeInsets.all(getScreenWidth(size));
  }

  static EdgeInsets rightPadding({double size = 20}) {
    return EdgeInsets.only(right: getScreenWidth(size));
  }

  static EdgeInsets leftPadding({double size = 20}) {
    return EdgeInsets.only(left: getScreenWidth(size));
  }

  static EdgeInsets bottomPadding({double size = 20}) {
    return EdgeInsets.only(bottom: getScreenWidth(size));
  }

  static EdgeInsets topPadding({double size = 20}) {
    return EdgeInsets.only(top: getScreenWidth(size));
  }

  static EdgeInsets verticalPadding({double size = 20}) {
    return EdgeInsets.symmetric(vertical: getScreenWidth(size));
  }

  static EdgeInsets horizontalPadding({double size = 20}) {
    return EdgeInsets.symmetric(horizontal: getScreenWidth(size));
  }

  static EdgeInsets onlyPadding({
    double top = 20,
    double left = 20,
    double right = 20,
    double bottom = 20,
  }) {
    return EdgeInsets.only(
      top: getScreenWidth(top),
      left: getScreenWidth(left),
      right: getScreenWidth(right),
      bottom: getScreenWidth(bottom),
    );
  }

  static EdgeInsets symmetricPadding({
    double vertical = 20,
    double horizontal = 20,
  }) {
    return EdgeInsets.symmetric(
      vertical: getScreenWidth(vertical),
      horizontal: getScreenWidth(horizontal),
    );
  }

  static double defaultRadius({double size = 20.0}) {
    return getScreenWidth(size);
  }
}

double getScreenHeight(double inputHeight) {
  double screenHeight = ResponsiveSize.screenHeight;
  return (inputHeight / 844.0) * screenHeight;
}

double getScreenWidth(double inputWidth) {
  double screenWidth = ResponsiveSize.screenWidth;
  return (inputWidth / 390.0) * screenWidth;
}
