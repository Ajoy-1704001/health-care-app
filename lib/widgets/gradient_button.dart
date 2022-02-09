import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: MyTheme().primaryGrad,
          borderRadius: BorderRadius.circular(20)),
      child: ElevatedButton(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(MyTheme().light),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
      ),
    );
  }
}
