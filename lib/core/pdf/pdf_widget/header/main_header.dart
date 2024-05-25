import 'package:grocery_app/core/pdf/pdf_widget/body/rectangle_with_border.dart';
import 'package:grocery_app/core/pdf/pdf_widget/header/header_text.dart';
import 'package:pdf/widgets.dart';

Widget mainHeader() {
  return Column(
    children: [
      rectangleWithBorder(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: headerText(
            name: "عرض المنتجات المختارة من البرنامج",
            address: "برمجة تسهيل للخدمات التقنية",
            email: "العنوان : اليمن - تعز - جولة سوفتيل",
            phoneNumber: "713345721 - 733290746 - 779780020",
          ),
        ),
      ),
    ],
  );
}

// ! Barcode
// Container(
//           height: 50,
//           width: 50,
//           child: BarcodeWidget(
//             barcode: Barcode.qrCode(),
//             data: invoice.info.number,
//           ),
//         ),
