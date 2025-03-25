import 'package:e_commerce_techware/controller/product_detail_screen_controller.dart';
import 'package:e_commerce_techware/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      context.read<ProductDetailScreenController>().getProductDetails(
        productId: widget.id.toString(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Product details screen",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorConstants.mainblack,
          ),
        ),
      ),
      body: Consumer<ProductDetailScreenController>(
        builder: (context, value, child) {
          return value.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 20,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              alignment: Alignment.topRight,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      value.productDetailModel!.images !=
                                                  null &&
                                              value
                                                  .productDetailModel!
                                                  .images!
                                                  .isNotEmpty
                                          ? NetworkImage(
                                            value
                                                .productDetailModel!
                                                .images!
                                                .first,
                                          )
                                          : AssetImage('assets/placeholder.png')
                                              as ImageProvider,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(6, 10),
                                      blurRadius: 10,
                                      color: ColorConstants.mainblack
                                          .withValues(alpha: 0.6),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.favorite_outline, size: 30),
                              ),
                            ),
                          ),
                          Text(
                            value.productDetailModel!.title.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "${value.productDetailModel!.rating.toString()}/5 rating",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            value.productDetailModel!.description.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              value.productDetailModel!.price.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 50),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // ontap functionality
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_mall_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Add to cart",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}
