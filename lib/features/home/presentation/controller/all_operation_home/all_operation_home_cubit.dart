import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/use_case/add_product_use_case.dart';
import 'package:grocery_app/features/product/domain/use_case/get_data_product_use_case.dart';

part 'all_operation_home_state.dart';

class AllOperationHomeCubit extends Cubit<AllOperationHomeState> {
  final GetDataProductUseCase getDataProductUseCase;
  final AddProductUseCase addProductUseCase;
  ProductEntities? productEntities;
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  AllOperationHomeCubit({
    required this.getDataProductUseCase,
    required this.addProductUseCase,
  }) : super(const AllOperationHomeState());

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(getSuccessState(index));
  }

  void changePageController(int index) {
    pageController.jumpToPage(index);
    emit(getSuccessState(index));
  }

  void showAllProduct(String code) async {
    emit(getLoadingState());
    final result = await getDataProductUseCase(
      upc: code, // "076410901473", //076410901473
    );
    result.fold(
      (failure) {
        emit(getErrorState(failure.message));
      },
      (data) {
        productEntities = data;
        addProduct(data);
        emit(const AllOperationHomeState(
          typeState: TypeState.success,
        ));
      },
    );
  }

  void addProduct(ProductEntities productData) async {
    final result = await addProductUseCase(productEntities: productData);
    result.fold(
      (failure) {
        // emit(getErrorState(failure.message));
      },
      (data) {
        emit(const AllOperationHomeState(
          typeState: TypeState.success,
          num: 100,
        ));
      },
    );
  }

  AllOperationHomeState getLoadingState() {
    return const AllOperationHomeState(
      typeState: TypeState.loading,
    );
  }

  AllOperationHomeState getErrorState(String errorMessage) {
    return AllOperationHomeState(
      typeState: TypeState.error,
      message: errorMessage,
    );
  }

  AllOperationHomeState getSuccessState(int num) {
    return AllOperationHomeState(typeState: TypeState.success, num: num);
  }
}
