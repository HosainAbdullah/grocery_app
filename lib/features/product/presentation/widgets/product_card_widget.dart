import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/theme/color_all_app.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/presentation/screens/show_detail_product_screen.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntities product;
  const ProductCardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDetailProductScreen(
                product: product,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffF1F1F5)),
          borderRadius: BorderRadius.circular(8),
        ),
        width: getScreenWidth(160),
        child: Stack(children: [
          Padding(
            padding: ResponsiveSize.defaultPadding(size: 8),
            child: Column(
              children: [
                InkResponse(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowDetailProductScreen(
                            product: product,
                          ),
                        ));
                  },
                  child: CachedNetworkImage(
                    width: getScreenWidth(160),
                    height: getScreenHeight(120),
                    imageUrl: product.proImage,
                    placeholder: (context, url) => const Center(
                      child:
                          CircularProgressIndicator(color: ColorAllApp.primary),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.photo_rounded,
                        color: Colors.grey.shade700,
                        size: 100,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getScreenHeight(6),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.price.toString(),
                    style: TextStyle(
                      color: ColorAllApp.primary,
                      fontSize: getScreenWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product.proName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: getScreenWidth(70),
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<AllOperationCartCubit, AllOperationCartState>(
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
                  return cartItem != null && cartItem.proID == product.proID
                      ? _buildCartActions(cartItem, context)
                      : _buildCartNoActions(product, context);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCartActions(CartItem cartItem, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xffE9F5FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkResponse(
        onTap: () {
          BlocProvider.of<AllOperationCartCubit>(context)
              .removeFromCarts(cartItem);
        },
        child: SvgPicture.asset(
          AssetsPath.assetsIcons + AssetsListName.icons[2],
          width: 28,
          height: 28,
        ),
      ),
    );
  }

  Widget _buildCartNoActions(ProductEntities product, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkResponse(
        onTap: () {
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
        child: SvgPicture.asset(
          AssetsPath.assetsIcons + AssetsListName.icons[0],
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
