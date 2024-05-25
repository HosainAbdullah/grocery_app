// import 'dart:developer';
// import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:pdf/widgets.dart';

// Future<MemoryImage> dataImageTitlePagePdf({required String logoName}) async {
//   if (logoName != "") {
//     log(logoName.toString());
//     return MemoryImage(
//       File(logoName).readAsBytesSync(),
//     );
//   } else {
//     log("else $logoName");
//     return MemoryImage(
//       (await rootBundle
//               .load(AssetsPath.assetsImages + AssetsListName.images[1]))
//           .buffer
//           .asUint8List(),
//     );
//   }
// }

Future<ThemeData> getThemeDataPdf() async {
  return ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("assets/fonts/arabic_regular.ttf")),
  );
}
