import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/core/widgets/text_field/search_text_field.dart';
import 'package:grocery_app/features/product/presentation/controller/all_operation_product/all_operation_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/features/product/presentation/widgets/product_card_widget.dart';

class ShowAllProductScreen extends StatelessWidget {
  const ShowAllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context: context);
    return Scaffold(
      appBar: MyAppBar(
          title: Padding(
            padding: ResponsiveSize.rightPadding(size: 16),
            child: SearchTextField(
              hint: StringsAllApp.searchProductsText.tr(context),
              readOnly: true,
            ),
          ),
          leading: InkResponse(
            onTap: () {
              Navigator.pop(context);
            },
            child: const BackButtonIcon(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AllOperationProductCubit, AllOperationProductState>(
          builder: (showAllProductContext, showAllProductState) {
            final scrollController = showAllProductContext
                .read<AllOperationProductCubit>()
                .scrollController;
            final productList = showAllProductContext
                .read<AllOperationProductCubit>()
                .productList;
            final page =
                showAllProductContext.read<AllOperationProductCubit>().page;
            if (showAllProductState.typeState == TypeState.loading) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 225,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffdddddd),
                        border: Border.all(color: const Color(0xffF1F1F5)),
                        borderRadius: BorderRadius.circular(8)),
                    width: (MediaQuery.of(context).size.width / 2) - 34,
                  );
                },
                itemCount: 6,
              );
            } else if (showAllProductState.typeState == TypeState.success) {
              return DefaultTabController(
                length: 3,
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    mainAxisExtent: 210,
                  ),
                  itemBuilder: (context, index) {
                    if (index < productList.length) {
                      return ProductCardWidget(
                        product: productList[index],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  itemCount: productList.length + (page < 8 ? 1 : 0),
                ),
              );
            } else if (showAllProductState.typeState == TypeState.error) {
              return Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetsPath.assetsIcons + AssetsListName.icons[1],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(showAllProductState.message),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        shape: const StadiumBorder(),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        StringsAllApp.refreshText.tr(context),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 225,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffdddddd),
                        border: Border.all(color: const Color(0xffF1F1F5)),
                        borderRadius: BorderRadius.circular(8)),
                    width: (MediaQuery.of(context).size.width / 2) - 34,
                  );
                },
                itemCount: 6,
              );
            }
          },
        ),
      ),
    );
  }
}
