import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      this.initialValue,
      this.onFieldSubmitted,
      this.onSaved,
      this.maxLines,
      required this.inputDecoration,
      this.textStyle,
      this.textValidator,
      required this.obscureText,
      this.keyboardType = TextInputType.text,
      this.textAlignment,
      this.capitalization = TextCapitalization.none,
      this.inputFormatters,
      this.onChanged,
      this.enabled});
  final String? initialValue;
  final Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final int? maxLines;
  final InputDecoration? inputDecoration;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? textValidator;
  final bool? obscureText;
  final TextInputType keyboardType;
  final TextAlign? textAlignment;
  final TextCapitalization capitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue ?? "",
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      decoration: inputDecoration,
      style: textStyle,
      validator: textValidator,
      obscureText: obscureText!,
      textAlign: textAlignment ?? TextAlign.start,
      keyboardType: keyboardType,
      textCapitalization: capitalization,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      enabled: enabled ?? true,
    );
  }
}
