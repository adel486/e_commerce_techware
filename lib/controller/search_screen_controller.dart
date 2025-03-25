import 'package:e_commerce_techware/model/Product%20model/productResModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SearchScreenController with ChangeNotifier {
  bool isLoading = false;
  ProductResModel? productData;
  getSearchNews(String query) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://dummyjson.com/products/search?q=$query");
    final responseData = await http.get(url);
    try {
      if (responseData.statusCode == 200) {
        productData = productResModelFromJson(responseData.body);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
