import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';
import 'package:grocery_app/core/widgets/text_field/text_field_all_app.dart';
import 'package:grocery_app/features/home/presentation/controller/all_operation_home/all_operation_home_cubit.dart';

class BarcodeTextFormField extends StatelessWidget {
  const BarcodeTextFormField({
    super.key,
    required this.barcodeController,
  });

  final TextEditingController barcodeController;

  @override
  Widget build(BuildContext context) {
    return TextFromFieldAllApp(
      validator: (barcode) {
        if (barcode!.isEmpty) {
          return "رقم الباركود";
        } else {
          return null;
        }
      },
      controller: barcodeController,
      // fillColor: ColorAllApp.textFieldColor,
      hintText: "رقم الباركود",
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      suffixIcon: InkWell(
        onTap: () async {
          final dataBarcodeScanner = await FlutterBarcodeScanner.scanBarcode(
              "#000000", "Cancel", true, ScanMode.BARCODE);
          if (dataBarcodeScanner != '-1') {
            barcodeController.text = dataBarcodeScanner;
          } else {
            barcodeController.text = '0';
          }
        },
        child: Padding(
          padding: ResponsiveSize.horizontalPadding(
            size: 15,
          ),
          child: const Icon(
            Icons.barcode_reader,
            color: ColorAllApp.primary,
          ),
        ),
      ),
      prefixIcon: InkWell(
        onTap: () {
          if (barcodeController.text.isNotEmpty) {
            BlocProvider.of<AllOperationHomeCubit>(context).showAllProduct(
              barcodeController.text,
            );
          }
        },
        child: Padding(
          padding: ResponsiveSize.horizontalPadding(
            size: 15,
          ),
          child: const Icon(
            Icons.search,
            color: ColorAllApp.primary,
          ),
        ),
      ),
    );
  }
}
