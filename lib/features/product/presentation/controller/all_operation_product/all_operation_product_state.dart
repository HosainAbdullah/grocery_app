part of 'all_operation_product_cubit.dart';

class AllOperationProductState extends Equatable {
  final TypeState typeState;
  final String message;

  const AllOperationProductState({
    this.typeState = TypeState.initial,
    this.message = "",
  });

  @override
  List<Object?> get props => [
        typeState,
        message,
      ];
}
