import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RichTextComponent extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  final int maxLines;

  const RichTextComponent({
    super.key,
    required this.title,
    required this.textStyle,
    this.textAlign,
    this.overflow,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.left,
        maxLines: maxLines,
        text: TextSpan(text: title, style: textStyle)); // todo
  }
}
