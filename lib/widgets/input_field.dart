import 'package:delivast_trial/resources/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String value;
  final bool isPassword;
  final bool enabled;
  final String suffixText;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry contentPadding;
  final String Function(String value) validator;
  final AutovalidateMode autovalidateMode;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const InputField({
    this.controller,
    this.hint,
    this.value,
    this.isPassword = false,
    this.enabled = true,
    this.suffixText,
    this.margin,
    this.contentPadding,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction = TextInputAction.go,
    this.keyboardType = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all((Radius.circular(12))),
      borderSide: BorderSide(color: Colors.grey[350], width: 1.1),
    );

    final style = TextStyle(
      color: textColor.withOpacity(0.9),
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    return Padding(
      padding: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null) ...[
            Text(
              hint,
              style: style,
            ),
            SizedBox(height: 20),
          ],
          TextFormField(
            controller: controller,
            autovalidateMode: autovalidateMode,
            initialValue: controller == null ? value : null,
            enabled: enabled,
            focusNode: focusNode,
            obscureText: isPassword,
            obscuringCharacter: '*',
            style: value != null ? style : null,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  width: 1.5,
                  color: primaryColor.withOpacity(0.75),
                ),
              ),
              hintText: value == null ? hint : null,
              suffixText: suffixText,
              suffixStyle: style.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              contentPadding: contentPadding,
            ),
          ),
        ],
      ),
    );
  }
}
