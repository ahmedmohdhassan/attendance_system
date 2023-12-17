import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.initialValue,
    this.maxLines,
    this.obscure = false,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.textInputAction,
    this.textInputType,
    this.validator,
    this.prefixIcon,
    this.suffixIconButton,
    this.controller,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? labelText;
  final String? initialValue;
  final int? maxLines;
  final bool obscure;
  final Function? onChanged;
  final Function? onSubmitted;
  final Function? onSaved;
  final Function? validator;
  final IconButton? suffixIconButton;
  final Icon? prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator as String? Function(String?)?,
      onChanged: onChanged as void Function(String)?,
      maxLines: maxLines,
      onFieldSubmitted: onSubmitted as void Function(String)?,
      onSaved: onSaved as void Function(String?)?,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscure,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.ltr,
        hintText: labelText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusColor: Colors.blue,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        suffixIcon: suffixIconButton,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class OnTapFormField extends StatelessWidget {
  const OnTapFormField(
      {Key? key,
      this.focusNode,
      this.labelText,
      this.initialValue,
      this.maxLines,
      this.obscure = false,
      this.onChanged,
      this.onSaved,
      this.onSubmitted,
      required this.onTap,
      this.textInputAction,
      this.textInputType,
      this.validator,
      this.prefixIconButton})
      : super(key: key);

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? labelText;
  final String? initialValue;
  final int? maxLines;
  final bool obscure;
  final Function? onChanged;
  final Function? onSubmitted;
  final Function? onSaved;
  final VoidCallback? onTap;
  final Function? validator;
  final IconButton? prefixIconButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: validator as String? Function(String?)?,
      onChanged: onChanged as void Function(String)?,
      maxLines: maxLines,
      onFieldSubmitted: onSubmitted as void Function(String)?,
      onSaved: onSaved as void Function(String?)?,
      onTap: onTap,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscure,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.ltr,
        hintText: labelText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusColor: Colors.blue,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        prefixIcon: prefixIconButton,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
