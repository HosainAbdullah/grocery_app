import 'package:grocery_app/core/enumaration/enum_type_pdf_save.dart';
import 'package:grocery_app/core/pdf/pdf_operation.dart';
import 'package:grocery_app/core/pdf/pdf_widget/footer/footer_text.dart';
import 'package:grocery_app/core/pdf/pdf_widget/header/data_image_title_page.dart';
import 'package:grocery_app/core/pdf/pdf_widget/header/main_header.dart';
import 'package:grocery_app/core/pdf/pdf_widget/header/title_page.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class CartItemReport {
  final List<CartItem> groupCartItem;
  final String langType;

  const CartItemReport({
    required this.groupCartItem,
    required this.langType,
  });
}

class CartPdfDesign {
  static Future<void> generate({
    required CartItemReport cartItemReport,
    required String? pathPDfFolder,
    required TypePdfSave typePdfSave,
  }) async {
    ThemeData myTheme = await getThemeDataPdf();
    final Document pdf = Document(
      pageMode: PdfPageMode.thumbs,
      theme: myTheme,
    );

    pdf.addPage(
      MultiPage(
        pageTheme: PageTheme(
          buildForeground: (context) => Container(
            padding: const EdgeInsets.all(20),
          ),
          clip: false,
          margin: const EdgeInsets.all(20),
          orientation: PageOrientation.portrait,
          pageFormat: PdfPageFormat.a4,
          textDirection: cartItemReport.langType == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
        ),
        header: (context) => mainHeader(),
        build: (context) => [
          SizedBox(height: 10),
          cartItemReport.langType == 'ar'
              ? titlePage(titlePage: "المنتجات")
              : titlePage(titlePage: "Products"),
          buildGroupCartItem(
              cartItemReport.groupCartItem, cartItemReport.langType),
        ],
        footer: (context) => footerText(
            pageNumber: context.pageNumber, langType: cartItemReport.langType),
      ),
    );

    if (typePdfSave == TypePdfSave.saveLocalAndShare) {
      await PdfOperation.savePdfAndShare(
        titleShare: "المنتجات",
        name: cartItemReport.langType == 'ar' ? 'المنتجات.pdf' : 'Products.pdf',
        pdf: pdf,
        pathPDfFolder: pathPDfFolder,
      );
    } else {
      await PdfOperation.saveDocument(
        name: cartItemReport.langType == 'ar' ? 'المنتجات.pdf' : 'Products.pdf',
        pdf: pdf,
        pathPDfFolder: pathPDfFolder,
      );
    }
  }

  static Widget buildGroupCartItem(
      List<CartItem> groupCartItem, String langType) {
    final headersAr = [
      'تاريخ الاضافة',
      'البراند',
      'السعر',
      'أسم المنتج',
      'الرقم',
    ];
    final headersEn = [
      'Added Date',
      'Phone number',
      'Account Category',
      'Account Name',
      'Account No',
    ];
    final data = groupCartItem.map((account) {
      return [
        account.createdDate,
        account.brandName,
        account.price,
        account.proName,
        account.proID,
      ];
    }).toList();
    return TableHelper.fromTextArray(
      headers: langType == 'ar' ? headersAr : headersEn,
      data: data,
      border: TableBorder.all(),
      headerDecoration: const BoxDecoration(color: PdfColors.blue100),
      cellHeight: 25,
      cellPadding: EdgeInsets.zero,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
      },
    );
  }
}
