import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_techware/controller/home_screen_controller.dart';
import 'package:e_commerce_techware/utils/constants/color_constants.dart';
import 'package:e_commerce_techware/view/product_detail_screen/product_details_screen.dart';
import 'package:e_commerce_techware/view/search%20screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      await context.read<HomeScreenController>().fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainwhite,
      appBar: AppBar(
        backgroundColor: ColorConstants.mainwhite,
        centerTitle: true,
        title: Text(
          "Home Screen",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
    
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Consumer<HomeScreenController>(
            builder: (context, value, child) {
              return value.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, welcome",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "${widget.username}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: ColorConstants.mainblack,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(radius: 30),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(
                                  context,
                                ).unfocus(); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchScreen(),
                                  ),
                                );
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search..",
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey.shade400,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: ColorConstants.mainblack,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),

                      // ✅ GridView.builder inside Column without Expanded
                      GridView.builder(
                        shrinkWrap: true, // ✅ Makes it fit inside the Column
                        physics:
                            NeverScrollableScrollPhysics(), // ✅ Prevents independent scrolling
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
                                                  .images![0] // ✅ Correct way to get first image
                                              : "https://images.pexels.com/photos/1926769/pexels-photo-1926769.jpeg?auto=compress&cs=tinysrgb&w=600",
                                        ),
                                        // ✅ Ensures proper image scaling
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
                                            .ellipsis, // ✅ Prevents overflow
                                  ),
                                  Text(
                                    value.productData!.products![index].price
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ],
                  );
            },
          ),
        ),
      ),
    );
  }
}
