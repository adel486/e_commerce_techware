
import 'package:e_commerce_techware/model/Product%20model/productResModel.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  bool isLoading = false;
  ProductResModel? productData;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://dummyjson.com/products");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        productData = productResModelFromJson(response.body);
      } else {
        print("Error: Failed to fetch products, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
