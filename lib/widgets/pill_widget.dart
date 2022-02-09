import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Pill extends StatelessWidget {
  const Pill(
      {Key? key,
      required this.pillName,
      required this.time,
      required this.time1,
      required this.onPress})
      : super(key: key);
  final String pillName;
  final String time;
  final String time1;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListTile(
          leading: Icon(
            LineIcons.pills,
            size: 35,
            color: Colors.grey,
          ),
          trailing: IconButton(
              onPressed: onPress,
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
              )),
          title: Text(pillName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800)),
          subtitle: Text(
            '$time  |  $time1',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
