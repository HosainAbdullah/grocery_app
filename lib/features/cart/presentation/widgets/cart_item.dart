import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD1DDE2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffE9F5FA)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item.proImage,
                    width: 40,
                    height: 40,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.proName,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(item.price,
                      style: const TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AllOperationCartCubit>(context)
                      .removeFromCarts(item);
                },
                child: const Icon(
                  Icons.delete,
                  color: Color(0xff2382AA),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
