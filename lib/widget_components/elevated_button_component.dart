import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonComponent extends StatelessWidget {
  const ElevatedButtonComponent(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.width,
      required this.height,
      required this.textStyle,
      this.loading = false,
      required this.textColor,
      required this.buttonColor});
  final double? width;
  final double? height;
  final Function(BuildContext context)? onPressed;
  final String? title;
  final Color? textColor;
  final Color? buttonColor;
  final bool loading;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width!,
        height: height!,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            foregroundColor: textColor!,
            backgroundColor: buttonColor!, // foreground (text) color
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title!,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Visibility(
                visible: loading,
                child: const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator()),
              ),
            ],
          ),
          onPressed: () {
            onPressed!(context);
          },
        ));
  }
}
