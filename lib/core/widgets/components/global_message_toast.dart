import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';

class GlobalMessageToast {
  static showMessageSuccess({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorAllApp.primary,
      textColor: ColorAllApp.white,
      fontSize: 16.0,
    );
  }

  static showMessageError({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorAllApp.red,
      textColor: ColorAllApp.white,
      fontSize: 16.0,
    );
  }

  static showMessageNots({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorAllApp.primary,
      textColor: ColorAllApp.white,
      fontSize: 16.0,
    );
  }
}
