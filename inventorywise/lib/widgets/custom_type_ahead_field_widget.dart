import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:InventoryWise/utils/app_theme.dart';

class CustomTypeAheadFieldWidget<T> extends StatelessWidget {
  CustomTypeAheadFieldWidget({
    Key? key,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.labelText,
    this.enabled = true,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.suggestionsCallback,
    this.textInputAction,
  }) : super(key: key);

  TextEditingController? controller;

  String? Function(String?)? validator;
  bool enabled;
  late FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  IconData? prefixIcon;
  late Widget Function(BuildContext, T) itemBuilder;
  late void Function(T) onSuggestionSelected;
  String? labelText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<T>(
      direction: AxisDirection.up,
      validator: validator,
      textFieldConfiguration: TextFieldConfiguration(
          enabled: enabled,
          controller: controller,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            fillColor: Colors.white,
            filled: true,
            labelText: labelText ?? '',
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: AppTheme.primaryColor,
                  ),
          )),
      noItemsFoundBuilder: (context) => Opacity(opacity: 0),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      )),
      suggestionsCallback: suggestionsCallback,
      itemBuilder: itemBuilder,
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}
