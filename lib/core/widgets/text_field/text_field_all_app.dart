import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/constants/responsive/responsive_size.dart';

class TextFromFieldAllApp extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final Color? fillColor;
  final int? maxLines;
  final TextInputAction textInputAction;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  const TextFromFieldAllApp({
    required this.controller,
    this.obscureText,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled,
    this.maxLines,
    this.inputFormatters,
    this.fillColor,
    this.onChanged,
    this.focusNode,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      maxLines: maxLines,
      obscureText: obscureText != null ? obscureText! : false,
      cursorColor: Theme.of(context).textTheme.headlineLarge!.color,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      inputFormatters: inputFormatters,
      style: const TextStyle(
          // color: TextColor.fontColor,
          ),
      onChanged: onChanged,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: ResponsiveSize.defaultPadding(size: 15),
        filled: true,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              // color: Colors.green.withOpacity(.5),
              ),
          borderRadius: BorderRadius.circular(getScreenWidth(15)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color.fromARGB(255, 219, 219, 219),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
