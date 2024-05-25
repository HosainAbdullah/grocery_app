import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Widget headerText({
  required String name,
  required String address,
  required String email,
  required String phoneNumber,
}) {
  return Container(
    width: PdfPageFormat.a4.width / 2.5,
    height: 100,
    child: Column(
      children: [
        SizedBox(
          height: 25,
          child: Text(
            textDirection: TextDirection.rtl,
            name,
            softWrap: true,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: Text(
            textDirection: TextDirection.rtl,
            address,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: Text(
            textDirection: TextDirection.rtl,
            phoneNumber,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: Text(
            textDirection: TextDirection.rtl,
            email,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}
