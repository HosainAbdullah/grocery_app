import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/core/widgets/components/see_all_view.dart';
import 'package:grocery_app/features/home/presentation/controller/all_operation_home/all_operation_home_cubit.dart';
import 'package:grocery_app/features/home/presentation/widgets/barcode_text_form_field.dart';
import 'package:grocery_app/features/home/presentation/widgets/card_barcode_widget.dart';
import 'package:grocery_app/features/home/presentation/widgets/circular_progress_search_widget.dart';
import 'package:grocery_app/features/home/presentation/widgets/not_search_widget.dart';
import 'package:grocery_app/features/home/presentation/widgets/show_error_in_search_widget.dart';
import 'package:grocery_app/features/product/presentation/controller/all_operation_product/all_operation_product_cubit.dart';
import 'package:grocery_app/features/product/presentation/screens/show_all_product_screen.dart';
import 'package:grocery_app/features/product/presentation/widgets/product_card_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context: context);
    final barcodeController = TextEditingController();
    return Scaffold(
      appBar: MyAppBar(
        leadingWidth: getScreenWidth(200),
        title: Text(
          StringsAllApp.groceryProductsText.tr(context),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Padding(
              padding: ResponsiveSize.defaultPadding(size: 16),
              child: BarcodeTextFormField(
                barcodeController: barcodeController,
              ),
            ),
            BlocConsumer<AllOperationHomeCubit, AllOperationHomeState>(
              listener: (homeContext, homeState) {
                if (homeState.typeState == TypeState.success &&
                    homeState.num == 100) {
                  BlocProvider.of<AllOperationProductCubit>(homeContext)
                      .showAllProductData();
                }
              },
              builder: (homeContext, homeState) {
                final itemData =
                    homeContext.read<AllOperationHomeCubit>().productEntities;

                return homeState.typeState == TypeState.initial
                    ? const NotSearchWidget()
                    : homeState.typeState == TypeState.loading
                        ? const CircularProgressSearchWidget()
                        : homeState.typeState == TypeState.error
                            ? const ShowErrorInSearchWidget()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CardBarCodeWidget(
                                  item: itemData,
                                ),
                              );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    height: getScreenHeight(12),
                  ),
                  SeeAllView(
                    context: context,
                    name: StringsAllApp.newlyAddedText.tr(context),
                    onTapAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowAllProductScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: getScreenHeight(12),
                  ),
                  SizedBox(
                    height: getScreenHeight(400),
                    child: BlocBuilder<AllOperationProductCubit,
                        AllOperationProductState>(
                      builder: (context, state) {
                        final productList = context
                            .read<AllOperationProductCubit>()
                            .productList;
                        return state.typeState == TypeState.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : state.typeState == TypeState.error
                                ? const ShowErrorInSearchWidget()
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                      mainAxisExtent: 210,
                                    ),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return ProductCardWidget(
                                        product: productList[index],
                                      );
                                    },
                                  );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
