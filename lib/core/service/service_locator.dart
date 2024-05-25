import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grocery_app/core/network/network_info.dart';
import 'package:grocery_app/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:grocery_app/features/cart/data/repository/cart_repository.dart';
import 'package:grocery_app/features/cart/domain/repository/base_cart_repository.dart';
import 'package:grocery_app/features/cart/domain/use_case/delete_all_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/delete_one_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/get_cart_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/save_cart_item_use_case.dart';
import 'package:grocery_app/features/product/data/data_source/product_remote_data_source.dart';
import 'package:grocery_app/features/product/data/repository/product_repository.dart';
import 'package:grocery_app/features/product/domain/repository/base_product_repository.dart';
import 'package:grocery_app/features/product/domain/use_case/add_product_use_case.dart';
import 'package:grocery_app/features/product/domain/use_case/get_all_product_use_case.dart';
import 'package:grocery_app/features/product/domain/use_case/get_data_product_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ? Product Use Case
  sl.registerLazySingleton(() => GetDataProductUseCase(
        baseProductRepository: sl(),
      ));
  sl.registerLazySingleton(() => GetAllProductUseCase(
        baseProductRepository: sl(),
      ));
  sl.registerLazySingleton(() => AddProductUseCase(
        baseProductRepository: sl(),
      ));

  // ? Cart Use Case
  sl.registerLazySingleton(() => SaveCartItemUseCase(
        baseCartRepository: sl(),
      ));
  sl.registerLazySingleton(() => GetCartItemUseCase(
        baseCartRepository: sl(),
      ));
  sl.registerLazySingleton(() => DeleteOneItemUseCase(
        baseCartRepository: sl(),
      ));
  sl.registerLazySingleton(() => DeleteAllItemUseCase(
        baseCartRepository: sl(),
      ));

  // Product Repository
  sl.registerLazySingleton<BaseProductRepository>(
    () => ProductRepository(
      productRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Cart Repository
  sl.registerLazySingleton<BaseCartRepository>(
    () => CartRepository(
      cartLocalStorage: sl(),
    ),
  );

  // ! Product Data Source
  sl.registerLazySingleton<BaseProductRemoteDataSource>(
      () => ProductRemoteDataSource(dio: sl()));
  // Cart Data Source
  sl.registerLazySingleton<BaseCartLocalDataSource>(
      () => CartLocalDataSource(sharedPreferences: sl()));

  // ! Core
  sl.registerLazySingleton<BaseNetworkInfo>(
      () => NetworkInfo(connectionChecker: sl()));
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        // baseUrl: ServerSittings.linkServer,
        // headers: {
        //   "x-app-key": "0a2b7ffc429bd0fc56e428efbd329de9",
        //   "x-app-id": "e32e3eb3",
        // },

        contentType: 'application/json',
      ),
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}
