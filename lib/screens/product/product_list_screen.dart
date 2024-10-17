import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_ecommerce/data/provider/product_provider.dart';
import 'package:demo_ecommerce/screens/product/product_detail_screen.dart';
import 'package:demo_ecommerce/themes/app_colors.dart';
import 'package:demo_ecommerce/widget_components/rich_text_component.dart';
import 'package:demo_ecommerce/widget_components/text_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: RichTextComponent(
          title: "Demo Ecom",
          textStyle: GoogleFonts.poppins(
              fontSize: 18.sp,
              color: AppColors.color1bb,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.notifications_none,
            size: 30.sp,
          ),
          SizedBox(
            width: 15.w,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            size: 30.sp,
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.all(25.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldComponent(
              textStyle: GoogleFonts.poppins(),
              // initialValue: "Testing@123",
              keyboardType: TextInputType.emailAddress,
              // textValidator: (value) =>
              //     PasswordFormFieldValidator.validate(value),
              // onSaved: (p0) => email = p0,
              obscureText: true,
              inputDecoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  hintText: "Search Product Name",
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.color262),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.color1bb, width: 2.w)),
                  fillColor: AppColors.color4ff,
                  filled: true),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: FutureBuilder(
                future: productProvider.getAllCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.color1bb,
                      ),
                    );
                  }
                  return Consumer<ProductProvider>(
                      builder: (context, productsConsumer, child) {
                    double gridWidth =
                        size.width / 2 - 16; // 2 items per row, with spacing
                    double aspectRatio = gridWidth /
                        242; // Calculating aspect ratio to get a fixed height of 242

                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichTextComponent(
                            title: "Categories",
                            textStyle: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 150.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: productsConsumer
                                .categoryModel.categories!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: 70.w,
                                      color:
                                          AppColors.color1bb.withOpacity(0.3),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: RichTextComponent(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        title: productsConsumer
                                            .categoryModel.categories![index],
                                        textStyle: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            color: AppColors.colorBlack,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichTextComponent(
                            title: "Featured Product",
                            textStyle: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        productsConsumer.productListModel.products == null
                            ? Center(
                                child: RichTextComponent(
                                  title: "Products Not available",
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: AppColors.colorBlack,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Expanded(
                                child: NotificationListener<ScrollNotification>(
                                  onNotification:
                                      (ScrollNotification scrollInfo) {
                                    if (!productsConsumer.isLoading &&
                                        scrollInfo.metrics.pixels ==
                                            scrollInfo
                                                .metrics.maxScrollExtent) {
                                      productsConsumer.loadMoreItems();
                                    }
                                    return true;
                                  },
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 items per row
                                      crossAxisSpacing:
                                          8.0, // Horizontal spacing between items
                                      mainAxisSpacing:
                                          8.0, // Vertical spacing between rows
                                      childAspectRatio:
                                          aspectRatio, // Aspect ratio of each item (width / height)
                                    ),
                                    itemCount: productsConsumer
                                            .lazyLoadingitems.length +
                                        (productsConsumer.isLoading
                                            ? 1
                                            : 0), // Add loading indicator at the end
                                    itemBuilder: (context, index) {
                                      if (index <
                                          productsConsumer
                                              .lazyLoadingitems.length) {
                                        return InkWell(
                                          onTap: () async {
                                            if (context.mounted) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailScreen(
                                                          productId:
                                                              productsConsumer
                                                                  .productListModel
                                                                  .products![
                                                                      index]
                                                                  .id!,
                                                        )),
                                              );
                                            }
                                          },
                                          child: Card(
                                            color: AppColors.colorWhite,
                                            elevation: 4.0,
                                            child: Container(
                                              margin: EdgeInsets.all(10.sp),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 125.h,
                                                    child: CachedNetworkImage(
                                                      imageUrl: productsConsumer
                                                          .productListModel
                                                          .products![index]
                                                          .image!,
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child: Shimmer
                                                                  .fromColors(
                                                        baseColor:
                                                            Colors.grey[300]!,
                                                        highlightColor:
                                                            Colors.grey[100]!,
                                                        child: Container(
                                                          width: size.width / 2,
                                                          height: 125,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  RichTextComponent(
                                                    maxLines: 2,
                                                    title: productsConsumer
                                                        .productListModel
                                                        .products![index]
                                                        .title!,
                                                    textStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize: 10.sp,
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  RichTextComponent(
                                                    title:
                                                        "\$${productsConsumer.productListModel.products![index].price!}",
                                                    textStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize: 14.sp,
                                                            color: AppColors
                                                                .colorRed,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  ),
                                ),
                              )
                      ],
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
