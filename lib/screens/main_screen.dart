import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/config.dart';
import 'package:healthcare/helper/shared_value_helper.dart';
import 'package:healthcare/screens/heart_prediction.dart';
import 'package:healthcare/screens/home_screen.dart';
import 'package:healthcare/screens/medicine_reminder.dart';
import 'package:healthcare/screens/profile_screen.dart';
import 'package:healthcare/screens/start_screen.dart';
import 'package:healthcare/widgets/gradient_button.dart';
import 'package:healthcare/widgets/navigation_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shake/shake.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  late LocationPermission permission;
  GlobalKey _key = GlobalKey();
  List<Widget> screens = [
    const HomeScreen(),
    const MedicineReminder(),
    Container(),
    const HeartDisease(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () async {
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
            headers: {'Content-Type': 'application/x-www-form-urlencoded'});

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
                    Text('Message has been sent', textAlign: TextAlign.center),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    setState(() {
                      index = 0;
                      key.currentState!.openEndDrawer();
                    });
                  },
                ),
                ListTile(
                  title: Text('Medicine Reminder'),
                  leading: Icon(LineIcons.pills),
                  onTap: () {
                    setState(() {
                      index = 1;
                      key.currentState!.openEndDrawer();
                    });
                  },
                ),
                ListTile(
                  title: Text('Heart Checker'),
                  leading: Icon(LineIcons.heart),
                  onTap: () {
                    setState(() {
                      index = 3;
                      key.currentState!.openEndDrawer();
                    });
                  },
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(LineIcons.user),
                  onTap: () {
                    setState(() {
                      index = 4;
                      key.currentState!.openEndDrawer();
                    });
                  },
                ),
                Spacer(),
                ListTile(
                    title: Text('Log Out'),
                    leading: Icon(LineIcons.alternateSignOut),
                    onTap: () {
                      auth.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(transitionsBuilder:
                                (context, animation, secondary, child) {
                              return SlideTransition(
                                position: animation.drive(Tween(
                                    begin: const Offset(0.1, 0.0),
                                    end: Offset.zero)),
                                child: child,
                              );
                            }, pageBuilder: (context, an, an2) {
                              return const StartScreen();
                            }),
                            (context) => false);
                      });
                    }),
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              key.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.sort_outlined,
              color: MyTheme().dark,
            ),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream:
                db.collection('users').doc(auth.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user_name.value = snapshot.data!.get('name');
                rescue_number.value = snapshot.data!.get('em_contact');
                user_image.value = snapshot.data!.get('image');
                return Column(
                  children: [
                    Expanded(child: screens[index]),
                    CustomNavigationBar(
                      currentIndex: index,
                      callback: (int value) {
                        setState(() {
                          index = value;
                          print('main $index');
                        });
                      },
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
