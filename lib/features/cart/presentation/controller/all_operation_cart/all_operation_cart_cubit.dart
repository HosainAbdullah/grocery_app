import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/core/enumaration/enum_type_pdf_save.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/core/pdf/pages_pdf/cart_pdf_design.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:grocery_app/features/cart/domain/use_case/delete_all_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/delete_one_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/get_cart_item_use_case.dart';
import 'package:grocery_app/features/cart/domain/use_case/save_cart_item_use_case.dart';

part 'all_operation_cart_state.dart';

class AllOperationCartCubit extends Cubit<AllOperationCartState> {
  final SaveCartItemUseCase saveCartItemUseCase;
  final GetCartItemUseCase getCartItemUseCase;
  final DeleteOneItemUseCase deleteOneItemUseCase;
  final DeleteAllItemUseCase deleteAllItemUseCase;

  AllOperationCartCubit({
    required this.saveCartItemUseCase,
    required this.getCartItemUseCase,
    required this.deleteOneItemUseCase,
    required this.deleteAllItemUseCase,
  }) : super(const AllOperationCartState());

  List<CartItem> cartListItem = [];

  void getCartItem() async {
    emit(getLoadingState());
    final result = await getCartItemUseCase();
    result.fold(
      (failure) {},
      (listCartItem) {
        cartListItem = listCartItem;
      },
    );
    emit(getSuccessState(cartListItem.length));
  }

  void addToCarts(CartItem cartItem) async {
    emit(getLoadingState());
    if (cartListItem.contains(cartItem)) {
    } else {
      cartListItem.add(cartItem);
      await saveCartItemUseCase(cartItem: cartListItem);
    }
    emit(getSuccessState(cartListItem.length));
  }

  void removeFromCarts(CartItem cartItem) async {
    emit(getLoadingState());
    if (cartListItem.contains(cartItem)) {
      cartListItem.remove(cartItem);
      await deleteOneItemUseCase(cartItem: cartItem);
    }
    emit(getSuccessState(cartListItem.length));
  }

  void printData() async {
    if (cartListItem.isNotEmpty) {
      emit(getLoadingState());
      CartItemReport cartItemReport = CartItemReport(
        groupCartItem: cartListItem,
        langType: "ar",
      );
      await CartPdfDesign.generate(
        cartItemReport: cartItemReport,
        pathPDfFolder: null,
        typePdfSave: TypePdfSave.saveLocal,
      );
      deleteAllCartItem();
    } else {
      emit(getErrorState('ليس لديك منتجات حاليا'));
    }
  }

  void printDataShare() async {
    if (cartListItem.isNotEmpty) {
      emit(getLoadingState());
      CartItemReport cartItemReport = CartItemReport(
        groupCartItem: cartListItem,
        langType: "ar",
      );
      await CartPdfDesign.generate(
        cartItemReport: cartItemReport,
        pathPDfFolder: null,
        typePdfSave: TypePdfSave.saveLocalAndShare,
      );
      deleteAllCartItem();
    } else {
      emit(getErrorState('ليس لديك منتجات حاليا'));
    }
  }

  void deleteAllCartItem() async {
    cartListItem.clear();
    await deleteAllItemUseCase();
    emit(getSuccessState(cartListItem.length));
  }

  AllOperationCartState getLoadingState() {
    return const AllOperationCartState(
      typeState: TypeState.loading,
    );
  }

  AllOperationCartState getErrorState(String errorMessage) {
    return AllOperationCartState(
      typeState: TypeState.error,
      message: errorMessage,
    );
  }

  AllOperationCartState getSuccessState(int number) {
    return AllOperationCartState(
      typeState: TypeState.success,
      number: number,
    );
  }
}
