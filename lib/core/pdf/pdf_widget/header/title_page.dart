import 'package:pdf/widgets.dart';

Widget titlePage({
  required String titlePage,
}) {
  return Center(
    child: Text(
      titlePage,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 15,
      ),
    ),
  );
}
