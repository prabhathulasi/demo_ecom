import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_ecommerce/data/model/cart_model.dart';
import 'package:demo_ecommerce/data/provider/cart_provider.dart';
import 'package:demo_ecommerce/data/provider/product_provider.dart';
import 'package:demo_ecommerce/themes/app_colors.dart';
import 'package:demo_ecommerce/widget_components/elevated_button_component.dart';
import 'package:demo_ecommerce/widget_components/rich_text_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size(0, 1),
          child: Divider(),
        ),
        backgroundColor: AppColors.colorWhite,
        centerTitle: true,
        title: RichTextComponent(
          title: "Detail Product",
          textStyle: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: AppColors.colorBlack,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 25.sp,
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(25.sp),
        height: size.height,
        width: size.width,
        child: FutureBuilder(
            future: productProvider.getProductDetail(productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<ProductProvider>(
                    builder: (context, productDetailConsumer, child) {
                  return Consumer<CartProvider>(
                      builder: (context, cartConsumer, child) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 300.h,
                              width: size.width,
                              child: CachedNetworkImage(
                                imageUrl: productDetailConsumer
                                    .productDetailModel.image!,
                                placeholder: (context, url) => Center(
                                    child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: size.width / 2,
                                    height: 125,
                                    color: Colors.white,
                                  ),
                                )),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          RichTextComponent(
                            maxLines: 2,
                            title:
                                productDetailConsumer.productDetailModel.title!,
                            textStyle: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RichTextComponent(
                            title:
                                "\$${productDetailConsumer.productDetailModel.price!}",
                            textStyle: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.colorRed,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              ElevatedButtonComponent(
                                  loading: cartConsumer.isLoading,
                                  onPressed: (context) {
                                    cartConsumer.addToCartList(CartProducts(
                                        productId: productDetailConsumer
                                            .productDetailModel.id,
                                        quantity: 1));
                                  },
                                  title: "Add to Cart",
                                  width: 170.w,
                                  height: 50.h,
                                  textStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  )),
                                  textColor: AppColors.color1bb,
                                  buttonColor: AppColors.colorWhite),
                              SizedBox(
                                width: 15.w,
                              ),
                              ElevatedButtonComponent(
                                  onPressed: (context) {},
                                  title: "Buy Now",
                                  width: 153.w,
                                  height: 50.h,
                                  textStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  )),
                                  textColor: AppColors.colorWhite,
                                  buttonColor: AppColors.color1bb),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          RichTextComponent(
                            title: "Description Product",
                            textStyle: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          RichTextComponent(
                            maxLines: 5,
                            title: productDetailConsumer
                                .productDetailModel.description!,
                            textStyle: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  });
                });
              }
            }),
      ),
      // persistentFooterButtons: [
      //   Container(
      //     width: size.width,
      //     height: 50.h,
      //     color: AppColors.color1bb,
      //     child: Center(
      //       child: RichTextComponent(
      //         title: "Check Out",
      //         textStyle: GoogleFonts.poppins(
      //             fontSize: 20.sp,
      //             color: AppColors.colorWhite,
      //             fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //   )
      // ],
    );
  }
}
