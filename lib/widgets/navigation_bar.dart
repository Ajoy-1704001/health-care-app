import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/config.dart';
import 'package:healthcare/helper/shared_value_helper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;

import 'gradient_button.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar(
      {Key? key, required this.callback, required this.currentIndex})
      : super(key: key);
  final ValueChanged<int> callback;
  final int currentIndex;

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late LocationPermission permission;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: MyTheme().dark,
            unselectedItemColor: MyTheme().transparentNav,
            currentIndex: widget.currentIndex,
            onTap: (value) {
              setState(() {
                widget.callback(value);
              });
              print(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(LineIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined), label: 'Medicine'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital_outlined), label: 'Health'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ]),
        Positioned(
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () async {
              permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                  showToast('Permission Denied');
                }
              }
              Position position = await Geolocator.getCurrentPosition();
              if (position != null) {
                print(position.latitude);
                var response = await http.post(
                    Uri.parse(
                        'http://66.45.237.70/api.php?username=${Config.username}&password=${Config.password}&number=88${rescue_number.value}&message=Please help!!! ${Config.location}${position.latitude},${position.longitude}'),
                    headers: {
                      'Content-Type': 'application/x-www-form-urlencoded'
                    });
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Emergency',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyTheme().primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        content: Wrap(
                          children: [
                            Text('Message has been sent',
                                textAlign: TextAlign.center),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GradientButton(
                                  title: 'Ok',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            )
                          ],
                        ),
                      );
                    });
              }
            },
            child: Container(
              width: 56,
              height: 56,
              child: const Icon(
                Icons.speaker_phone_outlined,
                size: 28,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, gradient: MyTheme().primaryGrad),
            ),
          ),
        )
      ],
    );
  }
}
