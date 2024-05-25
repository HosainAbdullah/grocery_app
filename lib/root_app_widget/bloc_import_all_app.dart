import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/lang/change_locale/change_locale_cubit.dart';
import 'package:grocery_app/core/service/service_locator.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/home/presentation/controller/all_operation_home/all_operation_home_cubit.dart';
import 'package:grocery_app/features/product/presentation/controller/all_operation_product/all_operation_product_cubit.dart';

class BlocImportAllApp extends StatelessWidget {
  final Widget rootAppWidget;
  const BlocImportAllApp({
    super.key,
    required this.rootAppWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeLocaleCubit(
            sharedPreferences: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => AllOperationProductCubit(
            getAllProductUseCase: sl(),
            getDataProductUseCase: sl(),
          )..showAllProductData(),
        ),
        BlocProvider(
          create: (context) => AllOperationHomeCubit(
            getDataProductUseCase: sl(),
            addProductUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (context) => AllOperationCartCubit(
            saveCartItemUseCase: sl(),
            deleteOneItemUseCase: sl(),
            getCartItemUseCase: sl(),
            deleteAllItemUseCase: sl(),
          )..getCartItem(),
        ),
      ],
      child: rootAppWidget,
    );
  }
}
