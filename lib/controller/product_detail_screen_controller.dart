import 'package:e_commerce_techware/model/product%20detail%20model/Products.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreenController with ChangeNotifier {
  Products? productDetailModel;
  bool isLoading = false;

  Future<void> getProductDetails({required String productId}) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://dummyjson.com/products/$productId");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      print("API Response: ${res.body}"); 

      try {
        productDetailModel = productsFromJson(res.body); 
        print(
          "Parsed Product: ${productDetailModel?.title}",
        ); 
      } catch (e) {
        print("Error parsing product details: $e"); 
      }
    } else {
      print("Failed to fetch product details. Status code: ${res.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }
}
