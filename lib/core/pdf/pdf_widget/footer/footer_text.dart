import 'package:pdf/widgets.dart';

Widget footerText({
  required int pageNumber,
  required String langType,
}) {
  return Column(
    children: [
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(langType == 'ar' ? 'تطبيق البقالة' : 'product'),
          Text(langType == 'ar'
              ? "رقم الصفحة : $pageNumber"
              : "Page Number : $pageNumber"),
          // Text(
          //   langType == 'ar'
          //       ? "تاريخ الطباعة : ${FunctionShareAllApp.dateToday()}"
          //       : "Printing Date : ${FunctionShareAllApp.dateToday()}",
          // ),
          Text(
            langType == 'ar'
                ? "تسهيل للخدمات التقنية - 733290746"
                : "Tashil of technical services - 733290746",
          ),
        ],
      ),
    ],
  );
}
