import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/features/product/domain/entities/product_entities.dart';
import 'package:grocery_app/features/product/domain/use_case/get_all_product_use_case.dart';
import 'package:grocery_app/features/product/domain/use_case/get_data_product_use_case.dart';

part 'all_operation_product_state.dart';

class AllOperationProductCubit extends Cubit<AllOperationProductState> {
  final GetDataProductUseCase getDataProductUseCase;
  final GetAllProductUseCase getAllProductUseCase;
  ProductEntities? productEntities;
  List<ProductEntities> productList = [];

  final ScrollController scrollController = ScrollController();
  int page = 1;

  AllOperationProductCubit({
    required this.getDataProductUseCase,
    required this.getAllProductUseCase,
  }) : super(const AllOperationProductState());

  void showAllProduct() async {
    emit(getLoadingState());

    final result = await getDataProductUseCase(
      upc: "076410901473", //076410901473
    );
    result.fold(
      (failure) {
        emit(getErrorState(failure.message));
      },
      (data) {
        productEntities = data;
        emit(const AllOperationProductState(
          typeState: TypeState.success,
        ));
      },
    );
  }

  void showAllProductData() async {
    emit(getLoadingState());

    final result = await getAllProductUseCase(
        //076410901473
        );
    result.fold(
      (failure) {
        emit(getErrorState(failure.message));
      },
      (data) {
        productList = data.productList;
        emit(const AllOperationProductState(
          typeState: TypeState.success,
        ));
      },
    );
  }

  AllOperationProductState getLoadingState() {
    return const AllOperationProductState(
      typeState: TypeState.loading,
    );
  }

  AllOperationProductState getErrorState(String errorMessage) {
    return AllOperationProductState(
      typeState: TypeState.error,
      message: errorMessage,
    );
  }
}
