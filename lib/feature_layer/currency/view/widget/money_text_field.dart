// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../../app/mixins/validation_mixin.dart';

class MoneyTextField extends StatelessWidget with ValidationsMixin {
  const MoneyTextField({
    super.key,
    required this.label,
    required this.prefixText,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.customColor,
    required this.errorText,
  });

  final String label;
  final String prefixText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function onSubmitted;
  final Color customColor;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: isNumeric,
      onTap: () {
        onSubmitted();
      },
      onFieldSubmitted: (value) {
        onSubmitted();
      },
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorText: errorText,
        hintStyle: TextStyle(color: customColor),
        labelText: label,
        labelStyle: TextStyle(
          color: customColor,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: customColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: customColor),
        ),
        prefixText: prefixText,
      ),
      style: TextStyle(color: customColor, fontSize: 25),
    );
  }
}
