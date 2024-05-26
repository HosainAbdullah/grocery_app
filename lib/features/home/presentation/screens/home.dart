import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';
import 'package:grocery_app/constants/strings/strings_all_app.dart';
import 'package:grocery_app/core/lang/app_localizations.dart';
import 'package:grocery_app/features/cart/presentation/controller/all_operation_cart/all_operation_cart_cubit.dart';
import 'package:grocery_app/features/home/presentation/controller/all_operation_home/all_operation_home_cubit.dart';
import 'package:grocery_app/features/home/presentation/screens/categories.dart';
import 'package:grocery_app/features/settings/presentation/screens/settings_screen.dart';

import 'package:grocery_app/features/home/presentation/screens/dashboard.dart';
import 'package:grocery_app/features/cart/presentation/screens/cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveSize().init(context: context);
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          BlocProvider.of<AllOperationHomeCubit>(context).currentIndex = 0;
        }
      },
      child: Scaffold(
        body: PageView(
          controller:
              BlocProvider.of<AllOperationHomeCubit>(context).pageController,
          onPageChanged: (index) {
            BlocProvider.of<AllOperationHomeCubit>(context)
                .changeCurrentIndex(index);
          },
          children: const [
            DashboardScreen(),
            Categories(),
            CartScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<AllOperationHomeCubit, AllOperationHomeState>(
      builder: (changeCurrentIndexContext, changeCurrentIndexState) {
        final currentIndex = changeCurrentIndexContext
            .read<AllOperationHomeCubit>()
            .currentIndex;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            changeCurrentIndexContext
                .read<AllOperationHomeCubit>()
                .changePageController(index);
          },
          items: [
            _buildBottomNavigationBarItem(
              currentIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
              StringsAllApp.homeText.tr(context),
            ),
            _buildBottomNavigationBarItem(
                currentIndex == 1
                    ? CupertinoIcons.cube_box_fill
                    : CupertinoIcons.cube_box,
                StringsAllApp.categoriesText.tr(
                  context,
                )),
            _buildCartNavigationBarItem(context),
            _buildBottomNavigationBarItem(
              currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
              StringsAllApp.settingsText.tr(context),
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    IconData icon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  BottomNavigationBarItem _buildCartNavigationBarItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: BlocBuilder<AllOperationCartCubit, AllOperationCartState>(
        builder: (cartContext, cartState) {
          final cartList =
              cartContext.read<AllOperationCartCubit>().cartListItem;

          return cartList.isNotEmpty
              ? Badge(
                  label: Text(
                    cartList.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  offset: const Offset(5, -5),
                  backgroundColor: Colors.red[600],
                  child: const Icon(Icons.shopping_cart_rounded),
                )
              : const Icon(Icons.shopping_cart_outlined);
        },
      ),
      label: StringsAllApp.cartText.tr(context),
    );
  }
}
