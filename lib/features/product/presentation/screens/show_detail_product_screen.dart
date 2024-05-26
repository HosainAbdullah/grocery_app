import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/core/widgets/alert/alert_show_image.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';

class ShowDetailProductScreen extends StatelessWidget {
  final ProductEntities product;
  const ShowDetailProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: Text(
            "تفاصيل المنتج",
            style: TextStyle(
                fontSize: getScreenWidth(16),
                fontWeight: FontWeight.bold,
                color: ColorAllApp.primary),
          ),
          leading: InkResponse(
            onTap: () {
              Navigator.pop(context);
            },
            // => Get.back(),
            child: const BackButtonIcon(),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.favorite_border_rounded),
            )
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkResponse(
                    onTap: () {
                      showDialog(
                        context: context,
                        // barrierColor: Colors.transparent,
                        builder: (context) => AlertShowImage(
                          linkImage: product.proImage,
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).primaryColor),
                              left: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).primaryColor),
                              right: BorderSide(
                                  width: 4,
                                  color: Theme.of(context).primaryColor)),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 140.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Hero(
                          tag: 1, // product.proID,
                          child: CachedNetworkImage(
                            imageUrl: product.proImage, // product.proImage,
                            width: 140,
                            height: 180,
                            filterQuality: FilterQuality.low,

                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.price,
                          style: const TextStyle(
                            color: Color(0xffFF324B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          product.proName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          product.brandName,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          product.description,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).cardColor.withOpacity(0.6),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text("Total price (with tax)",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            product.price,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: getScreenWidth(8),
                      ),
                      Expanded(
                        flex: 1,
                        child: BlocBuilder<AllOperationCartCubit,
                            AllOperationCartState>(
                          builder: (detailScreenContext, detailScreenState) {
                            CartItem? cartItem;
                            final indexItem = detailScreenContext
                                .read<AllOperationCartCubit>()
                                .cartListItem
                                .indexWhere(
                                  (element) => element.proID == product.proID,
                                );
                            if (indexItem != -1) {
                              cartItem = detailScreenContext
                                  .read<AllOperationCartCubit>()
                                  .cartListItem[indexItem];
                            }
                            return cartItem != null &&
                                    cartItem.proID == product.proID
                                ? _buildCartActions(cartItem, context)
                                : _buildCartNoActions(context);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartNoActions(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AllOperationCartCubit>(context).addToCarts(CartItem(
          proID: product.proID,
          upc: product.upc,
          proName: product.proName,
          price: product.price,
          proImage: product.proImage,
          brandName: product.brandName,
          description: product.description,
          createdDate: product.createdDate,
        ));
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: Text(
        StringsAllApp.addToCartText.tr(context),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCartActions(CartItem cartItem, BuildContext context) {
    return InkResponse(
      onTap: () {
        BlocProvider.of<AllOperationCartCubit>(context)
            .removeFromCarts(cartItem);
      },
      child: SvgPicture.asset(
        AssetsPath.assetsIcons + AssetsListName.icons[2],
        width: getScreenWidth(40),
        height: getScreenHeight(40),
      ),
    );
  }
}
