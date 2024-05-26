// import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:grocery_app/constants/path_const/assets_list.dart';
// import 'package:grocery_app/constants/path_const/local_path.dart';
// import 'package:grocery_app/constants/responsive/responsive_size.dart';
// import 'package:grocery_app/constants/theme/color_all_app.dart';
// import 'package:grocery_app/features/cart/data/model/cart.dart';
// import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
// import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
// import 'package:grocery_app/features/product/presentation/screens/show_detail_product_screen.dart';

// class VegetableCardWidget extends StatelessWidget {
//   final ProductEntities product;
//   const VegetableCardWidget({
//     Key? key,
//     required this.product,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     log(((MediaQuery.of(context).size.width / 2) - 34).toString());
//     return InkResponse(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ShowDetailProductScreen(
//                 product: product,
//               ),
//             ));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: const Color(0xffF1F1F5)),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         width: getScreenWidth(160),
//         // height: getScreenHeight(160),
//         child: Stack(children: [
//           Padding(
//             padding: ResponsiveSize.defaultPadding(size: 8),
//             child: Column(
//               children: [
//                 InkResponse(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ShowDetailProductScreen(
//                             product: product,
//                           ),
//                         ));
//                   },
//                   child: CachedNetworkImage(
//                     width: getScreenWidth(160),
//                     height: getScreenHeight(120),
//                     imageUrl: product.proImage,
//                     // filterQuality: FilterQuality.low,
//                     // colorBlendMode: BlendMode.overlay,
//                     // imageBuilder: (context, imageProvider) => Container(
//                     //   decoration: BoxDecoration(
//                     //     image: DecorationImage(
//                     //       image: imageProvider,
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //   ),
//                     // ),
//                     placeholder: (context, url) => const Center(
//                       child:
//                           CircularProgressIndicator(color: ColorAllApp.primary),
//                     ),
//                     errorWidget: (context, url, error) => Center(
//                       child: Icon(
//                         Icons.photo_rounded,
//                         color: Colors.grey.shade700,
//                         size: 100,
//                       ),
//                     ),
//                   ),

//                   // Hero(
//                   //   tag: product.proID,
//                   //   child: ,
//                   // ),
//                 ),
//                 SizedBox(
//                   height: getScreenHeight(6),
//                 ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     product.price.toString(),
//                     style: TextStyle(
//                       color: ColorAllApp.primary,
//                       fontSize: getScreenWidth(16),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   children: [
//                 //     Text(
//                 //       "20da",
//                 //       style: TextStyle(
//                 //           decoration: TextDecoration.lineThrough,
//                 //           color: Theme.of(context).colorScheme.primary,
//                 //           fontSize: 10,
//                 //           fontWeight: FontWeight.bold),
//                 //     ),
//                 //     const SizedBox(
//                 //       width: 8,
//                 //     ),
//                 //     const Text(
//                 //       // product.discount ??
//                 //       "20%",
//                 //       style: TextStyle(
//                 //           color: Color.fromARGB(255, 27, 133, 185),
//                 //           fontSize: 10,
//                 //           fontWeight: FontWeight.bold),
//                 //     ),
//                 //   ],
//                 // ),
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     product.proName,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: getScreenWidth(70),
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: BlocBuilder<AllOperationCartCubit, AllOperationCartState>(
//                 builder: (detailScreenContext, detailScreenState) {
//                   CartItem? cartItem;
//                   final indexItem = detailScreenContext
//                       .read<AllOperationCartCubit>()
//                       .cartListItem
//                       .indexWhere(
//                         (element) => element.proID == product.proID,
//                       );
//                   if (indexItem != -1) {
//                     cartItem = detailScreenContext
//                         .read<AllOperationCartCubit>()
//                         .cartListItem[indexItem];
//                   }

//                   // .contains(product.proID);
//                   //
//                   // element.proID == product.proID);
//                   log(indexItem.toString());
//                   log(cartItem.toString());
//                   // return const Text('data');
//                   // return indexItem != -1 &&  cartItem.proID == product.proID
//                   //     ? _buildCartActions(cartItem)
//                   //     : _buildCartNoActions(context);

//                   return cartItem != null && cartItem.proID == product.proID
//                       ? _buildCartActions(cartItem, context)
//                       : _buildCartNoActions(product, context);
//                 },
//               ),

//               // _buildCartActions(
//               //     CartItem(
//               //         proID: product.proID,
//               //         proImage: product.proImage,
//               //         proName: product.proName,
//               //         brandName: product.brandName,
//               //         description: product.description,
//               //         price: product.price,
//               //         upc: product.upc,
//               //         createdDate: product.createdDate),
//               //     context)

//               // Obx(
//               //   () {
//               //     // return _buildCartNoActions();
//               //     CartItem cartItem = CartItem(
//               //         proID: product.proID,
//               //         proImage: product.proImage,
//               //         proName: product.proName,
//               //         brandName: product.brandName,
//               //         description: product.description,
//               //         price: product.price,
//               //         upc: product.upc,
//               //         createdDate: product.createdDate);
//               //     return _buildCartActions(cartItem, context);
//               //     // final cartItem =
//               //     //     cartViewModel.productCartMap[product.proID.toString()];
//               //     // return cartItem != null && cartItem.id == product.proID
//               //     //     ? _buildCartActions(cartItem)
//               //     //     : _buildCartNoActions();
//               //   },
//               // ),
//             ),
//           ),
//           // Positioned(
//           //   top: 0, // to shift little up
//           //   left: 0,
//           //   child: Container(
//           //       width: 40,
//           //       height: 40,
//           //       //color: Colors.amber.shade100,
//           //       decoration: const BoxDecoration(
//           //           color: Color(0xffE9F5FA),
//           //           borderRadius:
//           //               BorderRadius.only(topLeft: Radius.circular(8))),
//           //       padding: const EdgeInsets.all(8),
//           //       child: Column(
//           //         children: [
//           //           Text(
//           //               // product.discount ??
//           //               "20%",
//           //               style: TextStyle(
//           //                   fontSize: 8,
//           //                   fontWeight: FontWeight.bold,
//           //                   color: Theme.of(context).primaryColor)),
//           //           Text("OFF",
//           //               style: TextStyle(
//           //                   fontSize: 8,
//           //                   fontWeight: FontWeight.bold,
//           //                   color: Theme.of(context).primaryColor))
//           //         ],
//           //       )),
//           // )
//         ]),
//       ),
//     );
//   }

//   Widget _buildCartActions(CartItem cartItem, BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         color: const Color(0xffE9F5FA),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: InkResponse(
//         onTap: () {
//           BlocProvider.of<AllOperationCartCubit>(context)
//               .removeFromCarts(cartItem);
//         },
//         child: SvgPicture.asset(
//           AssetsPath.assetsIcons + AssetsListName.icons[2],
//           width: 28,
//           height: 28,
//         ),

//         // Image.asset(
//         //   Assets.imagesRemoveIcon,
//         //   width: 28,
//         //   height: 28,
//         // ),
//       ),

//       // Row(
//       //   children: [
//       //     InkResponse(
//       //       onTap: () {
//       //         // cartViewModel.addToCart(cartItem);
//       //         BlocProvider.of<AllOperationCartCubit>(context)
//       //             .addToCarts(cartItem);
//       //       },
//       //       child: Image.asset(
//       //         Assets.imagesAddIcon,
//       //         width: 28,
//       //         height: 28,
//       //       ),
//       //     ),
//       //     const SizedBox(width: 4),
//       //     // Text(
//       //     //   (cartItem.itemQuantity).toString(),
//       //     //   style: const TextStyle(
//       //     //       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//       //     // ),
//       //     const SizedBox(width: 8),
//       //     InkResponse(
//       //       onTap: () {
//       //         // cartViewModel.removeFromCart(cartItem);
//       //       },
//       //       child: Image.asset(
//       //         Assets.imagesRemoveIcon,
//       //         width: 28,
//       //         height: 28,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }

//   Widget _buildCartNoActions(ProductEntities product, BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       child: InkResponse(
//         onTap: () {
//           BlocProvider.of<AllOperationCartCubit>(context).addToCarts(CartItem(
//             proID: product.proID,
//             upc: product.upc,
//             proName: product.proName,
//             price: product.price,
//             proImage: product.proImage,
//             brandName: product.brandName,
//             description: product.description,
//             createdDate: product.createdDate,
//           ));

//           // cartViewModel.addToCart(

//           // );
//         },
//         child: SvgPicture.asset(
//           AssetsPath.assetsIcons + AssetsListName.icons[0],
//           width: 28,
//           height: 28,
//         ),

//         // Image.asset(
//         //   Assets.imagesAddIcon,
//         //   width: 28,
//         //   height: 28,
//         // ),
//       ),
//     );
//   }
// }
