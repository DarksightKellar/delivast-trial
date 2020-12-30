import 'package:delivast_trial/resources/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final Size minimumSize;
  final VoidCallback onPressed;
  final BorderSide borderSide;

  const ActionButton({
    @required this.label,
    @required this.onPressed,
    this.backgroundColor = primaryColor,
    this.margin = const EdgeInsets.all(0.01),
    this.minimumSize,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextButton(
        child: label,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => backgroundColor,
          ),
          side: MaterialStateProperty.resolveWith(
            (states) => borderSide,
          ),
          minimumSize: MaterialStateProperty.resolveWith(
            (states) => minimumSize,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
