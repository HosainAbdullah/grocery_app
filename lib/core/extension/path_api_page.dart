class ServerSittings {
  static String linkServer = "https://trackapi.nutritionix.com/";
  static String linkServerMe = "https://hosainabdullah2020.pythonanywhere.com/";
  static const int receiveTimeout = 5000;
  static const int connectionTimeout = 5000;
}

enum PathServerPage {
  searchItem,
  allProduct,
}

extension ServerPathPageExtension on PathServerPage {
  String get rawValue {
    switch (this) {
      case PathServerPage.searchItem:
        return 'v2/search/item/';
      case PathServerPage.allProduct:
        return 'api/product/';
    }
  }
}
