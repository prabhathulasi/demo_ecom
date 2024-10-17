import 'package:demo_ecommerce/screens/product/product_list_screen.dart';
import 'package:demo_ecommerce/themes/app_colors.dart';
import 'package:demo_ecommerce/utils/validator.dart';
import 'package:demo_ecommerce/widget_components/elevated_button_component.dart';
import 'package:demo_ecommerce/widget_components/rich_text_component.dart';
import 'package:demo_ecommerce/widget_components/text_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String? email;
String? password;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 31.w, vertical: 97.h),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RichTextComponent(
                  title: "Login here",
                  textStyle: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      color: AppColors.color1bb,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 26.h,
                ),
                RichTextComponent(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  title: "Welcome back you’ve\nbeen missed!",
                  textStyle: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: AppColors.colorBlack,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 74.h,
                ),
                TextFieldComponent(
                  textStyle: GoogleFonts.poppins(),
                  initialValue: "testing@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  textValidator: (value) =>
                      EmailFormFieldValidator.validate(value),
                  onSaved: (p0) => email = p0,
                  obscureText: false,
                  inputDecoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.color262),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.color1bb, width: 2.w)),
                      fillColor: AppColors.color4ff,
                      filled: true),
                ),
                SizedBox(
                  height: 29.h,
                ),
                TextFieldComponent(
                  textStyle: GoogleFonts.poppins(),
                  initialValue: "Testing@123",
                  keyboardType: TextInputType.emailAddress,
                  textValidator: (value) =>
                      PasswordFormFieldValidator.validate(value),
                  onSaved: (p0) => email = p0,
                  obscureText: true,
                  inputDecoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.color262),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.color1bb, width: 2.w)),
                      fillColor: AppColors.color4ff,
                      filled: true),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: RichTextComponent(
                    title: "Forgot your password?",
                    textStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.color1bb,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButtonComponent(
                  buttonColor: AppColors.color1bb,
                  height: 60.h,
                  textColor: AppColors.colorWhite,
                  title: "Login",
                  textStyle: GoogleFonts.poppins(
                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                  width: size.width,
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductListScreen()),
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                RichTextComponent(
                  title: "Create new account",
                  textStyle: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.colorBlack,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 74.h,
                ),
                RichTextComponent(
                  title: "Or continue with",
                  textStyle: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppColors.color1bb,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook_outlined,
                      size: 40.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.apple_outlined,
                      size: 40.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.g_mobiledata,
                      size: 40.sp,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
