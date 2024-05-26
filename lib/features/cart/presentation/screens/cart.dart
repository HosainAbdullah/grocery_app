import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/core/extension/state_app.dart';
import 'package:grocery_app/core/widgets/app_bar/app_bar.dart';
import 'package:grocery_app/core/widgets/components/circular_progress_loading.dart';
import 'package:grocery_app/core/widgets/components/global_message_toast.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/cart/presentation/widgets/cart_item.dart';
import 'package:grocery_app/features/cart/presentation/widgets/empty_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text(
          "السلة 🛒",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: BlocConsumer<AllOperationCartCubit,
                        AllOperationCartState>(
                      listener: (dataCartContext, dataCartState) {
                        if (dataCartState.typeState == TypeState.error) {
                          GlobalMessageToast.showMessageNots(
                              message: dataCartState.message);
                        }
                      },
                      builder: (dataCartContext, dataCartState) {
                        final cartListItem = dataCartContext
                            .read<AllOperationCartCubit>()
                            .cartListItem;
                        return dataCartState.typeState == TypeState.loading
                            ? const CircularProgressLoading()
                            : cartListItem.isEmpty
                                ? const EmptyCartWidget()
                                : ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Color(0xffF1F1F5),
                                      );
                                    },
                                    itemCount: cartListItem.length,
                                    itemBuilder: (context, index) {
                                      return CartItemWidget(
                                        item: cartListItem[index],
                                      );
                                    },
                                  );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).cardColor.withOpacity(0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AllOperationCartCubit>(context)
                            .printDataShare();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const StadiumBorder(),
                        backgroundColor: Theme.of(context).disabledColor,
                      ),
                      child: const Text(
                        "مشاركة",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getScreenWidth(10),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AllOperationCartCubit>(context)
                            .printData();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const StadiumBorder(),
                        backgroundColor: Theme.of(context).disabledColor,
                      ),
                      child: const Text(
                        "عرض بي دي اف ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
