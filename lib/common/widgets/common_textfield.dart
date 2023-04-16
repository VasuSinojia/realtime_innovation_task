import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  TextEditingController controller;
  String? labelText, hintText;
  Icon? suffixIcon, prefixIcon;
  FocusNode? focus;
  VoidCallback? onTap;
  bool? readOnly;
  String? Function(String? value)? validator;

  CommonTextField(
      {Key? key,
      required this.controller,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.focus,
      this.onTap,
      this.readOnly,
      this.hintText,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 0.2, color: Colors.grey[200]!),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
