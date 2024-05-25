import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

class PdfOperation {
  static Future<void> saveDocument({
    required String name,
    required Document pdf,
    required String? pathPDfFolder,
  }) async {
    // final dir = await getApplicationDocumentsDirectory(); // الذاكرة
    // final dir = await getExternalStorageDirectory(); // الهاتف
    final bytes = await pdf.save();
    if (pathPDfFolder != null) {
      final dir = await getDirectoryInPhone();
      final file = File('${dir.path}/$name');
      final path = "${dir.path}/$name";
      final pathCopy = "$pathPDfFolder/$name";
      await file.writeAsBytes(bytes, flush: true);
      await OpenFile.open(
        path,
      );
      await copyFile(
        sourcePath: path,
        destinationPath: pathCopy,
      );
    } else {
      final dir = await getDirectoryInPhone();
      final file = File('${dir.path}/$name');
      final path = "${dir.path}/$name";
      await file.writeAsBytes(bytes, flush: true);
      await OpenFile.open(
        path,
      );
    }
  }

  static Future<void> savePdfAndShare({
    required String name,
    required Document pdf,
    required String titleShare,
    required String? pathPDfFolder,
  }) async {
    final bytes = await pdf.save();
    if (pathPDfFolder != null) {
      final file = File('$pathPDfFolder/$name');
      final path = "$pathPDfFolder/$name";
      await file.writeAsBytes(bytes, flush: true);
      await Share.shareXFiles(
        [
          XFile(path),
        ],
        text: titleShare,
      );
      // return path;
    } else {
      final dir = await getDirectoryInPhone();
      final file = File('${dir.path}/$name');
      final path = "${dir.path}/$name";
      await file.writeAsBytes(bytes, flush: true);
      await Share.shareXFiles(
        [
          XFile(path),
        ],
        text: titleShare,
      );
      // return path;
    }
  }

  static Future<int?> copyFile({
    required String sourcePath,
    required String destinationPath,
  }) async {
    final sourceFile = File(sourcePath);
    final destinationFile = File(destinationPath);

    try {
      await sourceFile.copy(destinationFile.path);
      return 1;
    } catch (e) {
      return null;
    }
  }

  static Future<Directory> getDirectoryInPhone() async {
    if (Platform.isAndroid) {
      final dir = await getExternalStorageDirectory(); // الذاكرة
      return dir!; // الهاتف
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      return dir;
    } else {
      return Directory("");
    }
  }
}
