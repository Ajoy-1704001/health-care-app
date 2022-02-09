import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/widgets/mini_solid_button.dart';
import 'package:line_icons/line_icons.dart';

class CheckList extends StatelessWidget {
  const CheckList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.iconData})
      : super(key: key);
  final String title;
  final String subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 40,
          color: MyTheme().dark,
        ),
        Container(),
        Expanded(
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                  color: MyTheme().dark,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: MyTheme().subtitle, fontSize: 12),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        //   width: 65,
        //   child: MiniSolidButton(
        //       callback: () {},
        //       label: 'Done',
        //       backgroundColor: MyTheme().light,
        //       fontSize: 11),
        // )
      ],
    );
  }
}
