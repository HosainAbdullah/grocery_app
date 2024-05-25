part of 'all_operation_cart_cubit.dart';

class AllOperationCartState extends Equatable {
  final TypeState typeState;
  final String message;
  final int number;

  const AllOperationCartState({
    this.typeState = TypeState.initial,
    this.message = "",
    this.number = 0,
  });

  @override
  List<Object?> get props => [
        typeState,
        message,
        number,
      ];
}
