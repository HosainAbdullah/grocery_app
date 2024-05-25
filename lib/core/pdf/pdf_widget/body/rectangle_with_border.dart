import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget rectangleWithBorder({
  required Widget child,
  double? width,
  double? height,
  double widthBorder = 1.0,
  EdgeInsets? padding,
}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
    decoration: BoxDecoration(
      border: Border.all(
        color: PdfColors.black,
        style: BorderStyle.solid,
        width: widthBorder,
      ),
    ),
    child: child,
  );
}
