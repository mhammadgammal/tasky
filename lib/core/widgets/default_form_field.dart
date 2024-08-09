import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class DefaultFormFiled extends StatefulWidget {
  const DefaultFormFiled({
    super.key,
    required this.controller,
    required this.inputType,
    required this.fieldLabel,
    required this.icon,
    required this.validate,
    this.isEnabled = true,
    this.obSecure = false,
    this.suffixIcon,
    this.initialValue,
    this.maxLines,
    this.labelColor = AppColor.lightGrey,
    this.iconColor = AppColor.lightGrey,
    this.textFieldTextColor = Colors.black,
    this.onChanged,
    this.cursorColor = Colors.deepPurple,
    this.autoFocus = false,
    this.focusNode,
    this.onSubmit,
  });

  final TextEditingController controller;
  final TextInputType inputType;
  final String? fieldLabel;
  final Icon? icon;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final bool obSecure;
  final IconButton? suffixIcon;
  final int? maxLines;
  final bool isEnabled;
  final String? initialValue;
  final Color labelColor;
  final Color iconColor;
  final Color textFieldTextColor;
  final Color cursorColor;
  final bool autoFocus;
  final FocusNode? focusNode;
  final void Function(String?)? onSubmit;

  @override
  State<DefaultFormFiled> createState() => _DefaultFormFiledState();
}

class _DefaultFormFiledState extends State<DefaultFormFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.inputType,
      style: TextStyle(color: widget.textFieldTextColor),
      decoration: InputDecoration(
        labelText: widget.fieldLabel,
        labelStyle: TextStyle(color: widget.labelColor),
        prefixIcon: widget.icon,
        suffixIcon: widget.suffixIcon,
        iconColor: widget.iconColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: AppColor.lightGrey, width: 1.5)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: AppColor.mainColor, style: BorderStyle.solid, width: 3.0),
        ),
      ),
      maxLines: widget.maxLines,
      cursorColor: widget.cursorColor,
      initialValue: widget.initialValue,
      enabled: widget.isEnabled,
      obscureText: widget.obSecure,
      onChanged: widget.onChanged,
      validator: widget.validate,
      onFieldSubmitted: widget.onSubmit,
    );
  }
}
