part of 'all_operation_home_cubit.dart';

class AllOperationHomeState extends Equatable {
  final TypeState typeState;
  final String message;
  final int num;
  const AllOperationHomeState({
    this.typeState = TypeState.initial,
    this.message = "",
    this.num = 0,
  });

  @override
  List<Object?> get props => [
        typeState,
        message,
        num,
      ];
}
