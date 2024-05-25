import 'dart:convert';

import 'package:grocery_app/core/error/exceptions.dart';
import 'package:grocery_app/core/settings/keys_shared_preferences.dart';
import 'package:grocery_app/features/cart/data/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseCartLocalDataSource {
  Future<List<CartItem>> selectCartItem();
  Future<bool> removeCartItem({required CartItem cartItem});
  Future<bool> saveCartItem({required List<CartItem> cartItem});
  Future<bool> deleteAllItem();
}

class CartLocalDataSource implements BaseCartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<List<CartItem>> selectCartItem() {
    final jsonString =
        sharedPreferences.getString(KeysSharedPreferences.cartItemList);
    if (jsonString != null) {
      List<CartItem> cartItemList = convertStringToList(jsonString);

      return Future.value(cartItemList);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<bool> removeCartItem({required CartItem cartItem}) async {
    final jsonString =
        sharedPreferences.getString(KeysSharedPreferences.cartItemList);
    if (jsonString != null) {
      List<CartItem> cartItemList = convertStringToList(jsonString);
      if (cartItemList.contains(cartItem)) {
        cartItemList.remove(cartItem);
        List postModelsToJson = cartItemList
            .map<Map<String, dynamic>>((postModel) => postModel.toJson())
            .toList();
        await sharedPreferences.setString(
            KeysSharedPreferences.cartItemList, json.encode(postModelsToJson));
        return true;
      } else {
        return false;
      }
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<bool> saveCartItem({required List<CartItem> cartItem}) async {
    List postModelsToJson = cartItem
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    final result = await sharedPreferences.setString(
        KeysSharedPreferences.cartItemList, json.encode(postModelsToJson));
    return result;
  }

  List<CartItem> convertStringToList(String dataCached) {
    List decodeJsonData = json.decode(dataCached);
    List<CartItem> jsonToCartItem = decodeJsonData
        .map<CartItem>((jsonCartItem) => CartItem.fromMap(jsonCartItem))
        .toList();

    return jsonToCartItem;
  }

  @override
  Future<bool> deleteAllItem() async {
    final result = await sharedPreferences.remove(
      KeysSharedPreferences.cartItemList,
    );
    return result;
  }
}
