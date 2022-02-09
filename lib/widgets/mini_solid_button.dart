import 'package:flutter/material.dart';

class MiniSolidButton extends StatelessWidget {
  const MiniSolidButton(
      {Key? key,
      required this.callback,
      required this.label,
      required this.backgroundColor,
      required this.fontSize})
      : super(key: key);
  final VoidCallback callback;
  final String label;
  final Color backgroundColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: fontSize),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
        ),
      ),
    );
  }
}
