import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/core/widgets/text_field/search_text_field.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';

class VegetableDetailScreen extends StatelessWidget {
  final ProductEntities product;
  const VegetableDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: const SearchTextField(
            hint: "What are u looking for ?",
            readOnly: true,
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => PhotoViewGallery.builder(
                      //         scrollPhysics: const BouncingScrollPhysics(),
                      //         builder: (BuildContext context, int index) {
                      //           return PhotoViewGalleryPageOptions(
                      //             maxScale:
                      //                 PhotoViewComputedScale.covered * 1.1,
                      //             minScale:
                      //                 PhotoViewComputedScale.contained * 0.8,
                      //             imageProvider: CachedNetworkImageProvider(
                      //               product.proImage,
                      //             ),
                      //             initialScale:
                      //                 PhotoViewComputedScale.contained * 0.8,
                      //             heroAttributes: PhotoViewHeroAttributes(
                      //               tag: product.proID,
                      //             ),
                      //           );
                      //         },
                      //         itemCount: 1,
                      //         pageController: PageController(initialPage: 0),
                      //       ),
                      //     ));

                      // Get.to(() =>

                      // )
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
                        const Text(
                          // "${product.price} / ${10}",
                          "000",
                          style: TextStyle(
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
                          // "tags: ${product.brandName}",
                          product.description,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                        // const SizedBox(
                        //   height: 32,
                        // ),
                        // const Row(
                        //   children: [
                        //     ItemKeyPointsView(
                        //       imagePath: Assets.imagesOrganic,
                        //       title: "100%",
                        //       desc: "Organic",
                        //     ),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     ItemKeyPointsView(
                        //       imagePath: Assets.imagesHouse,
                        //       title: "1 Year",
                        //       desc: "Expiration",
                        //     )
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // const Row(
                        //   children: [
                        //     ItemKeyPointsView(
                        //         imagePath: Assets.imagesReviews,
                        //         title: "4.8",
                        //         desc: "Reviews"),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     ItemKeyPointsView(
                        //         imagePath: Assets.imagesCalories,
                        //         title: "80 kcal",
                        //         desc: "200 Gram")
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
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
                      const SizedBox(
                        width: 8,
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

                            // .contains(product.proID);
                            //
                            // element.proID == product.proID);
                            log(indexItem.toString());
                            log(cartItem.toString());
                            // return const Text('data');
                            // return indexItem != -1 &&  cartItem.proID == product.proID
                            //     ? _buildCartActions(cartItem)
                            //     : _buildCartNoActions(context);

                            return cartItem != null &&
                                    cartItem.proID == product.proID
                                ? _buildCartActions(cartItem, context)
                                : _buildCartNoActions(context);
                          },
                        ),
                        // Obx(
                        //   () {
                        //     return _buildCartNoActions();
                        // final cartItem = cartViewModel
                        //     .productCartMap[product.proID.toString()];
                        // return cartItem != null &&
                        //         cartItem.id == product.proID
                        //     ? _buildCartActions(cartItem)
                        //     : _buildCartNoActions();
                        //   },
                        // ),
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
      child: const Text(
        "Add to cart",
        style: TextStyle(color: Colors.white),
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
      ),

      // Image.asset(
      //   Assets.imagesRemoveIcon,
      //   width: 40,
      //   height: 40,
      // ),
    );

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     InkResponse(
    //       onTap: () {
    //         // cartViewModel.addToCart(cartItem);
    //       },
    //       child: Image.asset(
    //         Assets.imagesAddIcon,
    //         width: 40,
    //         height: 40,
    //       ),
    //     ),
    //     const SizedBox(width: 20),
    //     // Text(
    //     //   (cartItem.itemQuantity).toString(),
    //     //   style: const TextStyle(
    //     //     fontSize: 16,
    //     //     fontWeight: FontWeight.bold,
    //     //   ),
    //     // ),
    //     const SizedBox(width: 20),
    //     InkResponse(
    //       onTap: () {
    //         // cartViewModel.removeFromCart(cartItem);
    //       },
    //       child: Image.asset(
    //         Assets.imagesRemoveIcon,
    //         width: 40,
    //         height: 40,
    //       ),
    //     ),
    //   ],
    // );
  }
}
