import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_techware/controller/search_screen_controller.dart';
import 'package:e_commerce_techware/utils/constants/color_constants.dart';
import 'package:e_commerce_techware/view/product_detail_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SearchBar(
                onChanged: (value) async {
                  if (value.length.isEven) {
                    await context.read<SearchScreenController>().getSearchNews(
                      value,
                    );
                  }
                },
                leading: Icon(Icons.search, color: Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                textStyle: WidgetStatePropertyAll(
                  TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                child: Consumer<SearchScreenController>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    // ✅ Check if productData or its products list is null or empty
                    if (value.productData == null ||
                        value.productData!.products == null ||
                        value.productData!.products!.isEmpty) {
                      return Center(
                        child: Text(
                          "No products found",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                     
                        itemCount: value.productData!.products!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          mainAxisExtent: 250,
                        ),
                        itemBuilder:
                            (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductDetailsScreen(
                                          id:
                                              value
                                                  .productData!
                                                  .products![index]
                                                  .id!,
                                        ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorConstants.mainwhite,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          value
                                                  .productData!
                                                  .products![index]
                                                  .images!
                                                  .isNotEmpty
                                              ? value
                                                  .productData!
                                                  .products![index]
                                                  .images![0] 
                                              : "https://images.pexels.com/photos/1926769/pexels-photo-1926769.jpeg?auto=compress&cs=tinysrgb&w=600",
                                        ),
                                        
                                      ),
                                    ),
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.mainwhite,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.favorite_outline,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    value.productData!.products![index].title ??
                                        "No brand name",
                                    style: GoogleFonts.poppins(
                                      color: ColorConstants.mainblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow:
                                        TextOverflow
                                            .ellipsis,
                                  ),
                                  Text(
                                    value.productData!.products![index].price
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
