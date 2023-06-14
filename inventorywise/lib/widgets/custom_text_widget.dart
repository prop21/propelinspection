import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:InventoryWise/utils/app_theme.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(
      {Key? key,
      this.controller,
      this.helperValue = "",
      this.validator,
      this.readOnly = false,
      this.isEnabled = true,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.hintValue,
      this.onChanged,
      this.prefixIconColor,
      this.type,
      this.prefixText,
      this.textCapitalization = TextCapitalization.none,
      this.prefixWidget,
      this.fillColor,
      // this.textColor = null,
      this.maxLength = 30,
      this.onSubmit,
      this.helperTextStyle,
      this.focusNode,
      this.upperLabel,
      this.onEditingComplete,
      // this.textInputAction,
      this.borderRadius,
      this.inputFormatters,
      this.textInputAction,
      this.autofocus = false})
      : super(key: key);
  final String? hintValue;
  final dynamic helperValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? prefixText;
  final Widget? prefixWidget;
  final Color? fillColor;
  final Color? prefixIconColor;
  final dynamic suffixIcon;
  final TextInputType? type;
  final String? upperLabel;
  // TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final dynamic onEditingComplete;
  final int maxLength;
  final dynamic onSubmit;
  final TextStyle? helperTextStyle;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final BorderRadius? borderRadius;
  final bool autofocus;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: helperValue.contains("null") ? 50 : 90,
      // decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(10),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Color(0xff111111).withOpacity(.2),
      //                     offset: Offset(0, 0),
      //                     blurRadius: 5,
      //                     // spreadRadius: 3
      //                     )
      //               ]),
      child: AbsorbPointer(
        absorbing: readOnly,
        child: TextFormField(
          autofocus: autofocus,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            fontSize: 17,
            //  color: textColor == null
            //         ? Colors.black
            //         : textColor
          ),
          readOnly: readOnly,
          enabled: isEnabled,
          // style: new TextStyle(
          //     color: textColor == null
          //         ? ThemeConstants.primaryTextColor
          //         : textColor),
          focusNode: focusNode,
          // cursorColor: ThemeConstants.accentColor,
          keyboardType: type,
          // autocorrect: false,
          // enableSuggestions: false,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.zero,

            suffixIcon: suffixIcon,
            // suffixIcon: (suffixIcon != null)
            //     ? Icon(
            //         suffixIcon,
            //         color: Colors.black,
            //       )
            //     : null,
            prefixIcon: (prefixIcon != null)
                ? Icon(
                    prefixIcon,
                    color: prefixIconColor ?? AppTheme.primaryColor,
                  )
                : prefixText != (null)
                    ? prefixText
                    : null,
            prefix: prefixWidget,
            // prefix: (prefixIcon != null)
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //         child:
            //             Icon(prefixIcon, color: AppTheme.primaryColor, size: 24),
            //       )
            //     : prefixWidget,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius:
            //       borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: BorderSide(
            //     color: AppTheme.primaryColor,
            //     width: 0.5,
            //   ),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius:
            //       borderRadius ?? const BorderRadius.all(Radius.circular(15.0)),
            //   borderSide: const BorderSide(
            //     color: Colors.red,
            //     width: 0.1,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius:
            //       borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
            //   borderSide: const BorderSide(
            //     width: 0.5,
            //     // style: BorderStyle.none,
            //   ),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(10.0)),
              // borderSide: const BorderSide(
              // width: 0.5,
              // style: BorderStyle.none,
              // ),
            ),
            fillColor: fillColor == (null) ? Colors.white : fillColor,
            // fillColor: Colors.yellow,

            filled: true,
            // focusColor: ThemeConstants.accentColor,
            counterText: "",
            helperText: helperValue,

            // helperText: helperValue.contains("null") ? null : helperValue,
            // helperStyle: TextStyle(
            //     color: textColor == null
            //         ? ThemeConstants.primaryTextColor
            //         : textColor),
            labelText: upperLabel,

            // floatingLabelBehavior: FloatingLabelBehavior.never,
            // alignLabelWithHint: false,
            // floatingLabelStyle: TextStyle(letterSpacing: 0),
            // labelStyle: TextStyle(
            // color: AppTheme.primaryColor,
            // inherit: false
            // decorationThickness: 0.6
            // debugLabel: "sdsd"
            // textBaseline: TextBaseline.ideographic
            // ),
            hintText: hintValue,
            // hintStyle: TextStyle(
            //     color: textColor == null
            //         ? ThemeConstants.secondaryTextColor
            //         : textColor),
          ),
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          maxLength: maxLength,
          onFieldSubmitted: onSubmit,
        ),
      ),
    );
  }
}
