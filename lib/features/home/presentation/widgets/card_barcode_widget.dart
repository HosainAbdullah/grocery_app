import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/constants/path_const/assets_list.dart';
import 'package:grocery_app/constants/path_const/local_path.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/home/presentation/widgets/not_search_widget.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';

class CardBarCodeWidget extends StatelessWidget {
  final ProductEntities? item;
  const CardBarCodeWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffF1F1F5)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffE9F5FA)),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: item!.proImage,
                    width: 40,
                    height: 40,
                    filterQuality: FilterQuality.none,
                    //fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item!.proName,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(item!.price,
                        style: const TextStyle(
                            color: Color(0xffFF324B),
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (() {
                    BlocProvider.of<AllOperationCartCubit>(context)
                        .addToCarts(CartItem(
                      proID: item!.proID,
                      upc: item!.upc,
                      proName: item!.proName,
                      price: item!.price,
                      proImage: item!.proImage,
                      brandName: item!.brandName,
                      description: item!.description,
                      createdDate: item!.createdDate,
                    ));
                  }),
                  child: SvgPicture.asset(
                    AssetsPath.assetsIcons + AssetsListName.icons[0],
                    width: 38,
                    height: 38,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const NotSearchWidget();
    }
  }
}
