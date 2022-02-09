import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/widgets/gradient_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddPill extends StatefulWidget {
  const AddPill({Key? key}) : super(key: key);

  @override
  _AddPillState createState() => _AddPillState();
}

class _AddPillState extends State<AddPill> {
  TextEditingController pName = TextEditingController();
  TextEditingController pQuantity = TextEditingController(text: '1');
  TextEditingController pDays = TextEditingController(text: '5');
  TextEditingController pNotification = TextEditingController(text: '');
  int sValue = 1;
  List<String> timeTable = ['Before Eating', 'After Eating'];
  List<String> timeTile = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late OverlayEntry loader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tz.initializeTimeZones();
    loader = Global.overlayLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: MyTheme().transparentNav),
                child: IconButton(
                    iconSize: 19,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyTheme().dark,
                    )),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Alarm',
                        style: TextStyle(
                            color: MyTheme().dark,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Medicine Name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: pName,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            prefixIcon: const Icon(
                              LineIcons.pills,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Amount & How Long?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: pQuantity,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: '1',
                                  prefixIcon: const Icon(
                                    LineIcons.pills,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text('Pills'),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              controller: pDays,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: '1',
                                  prefixIcon: const Icon(
                                    LineIcons.calculator,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text('Days'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Food & Medicine',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      for (int i = 1; i <= 2; i++)
                        ListTile(
                          title: Text(
                            timeTable[i - 1],
                            // style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == 2 ? Colors.black38 : shrineBrown900),
                          ),
                          leading: Radio(
                            value: i,
                            groupValue: sValue,
                            onChanged: (int? value) {
                              setState(() {
                                sValue = value!;
                              });
                            },
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Notification',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: pNotification,
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                  hintText: 'Time',
                                  prefixIcon: const Icon(
                                    LineIcons.calculator,
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: MyTheme().transparentNav),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: IconButton(
                                  iconSize: 19,
                                  onPressed: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: DateTime.now().hour,
                                          minute: DateTime.now().minute),
                                    );
                                    if (newTime != null) {
                                      setState(() {
                                        pNotification.text =
                                            pNotification.value.text +
                                                newTime.format(context) +
                                                '  ';
                                        String d = DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day,
                                                newTime.hour,
                                                newTime.minute)
                                            .toString();
                                        timeTile.add(d);
                                        // print(tz.TZDateTime.parse(tz.local, d));

                                        // print(DateTime(
                                        //     DateTime.now().year,
                                        //     DateTime.now().month,
                                        //     DateTime.now().day,
                                        //     newTime.hour,
                                        //     newTime.minute));
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: MyTheme().dark,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GradientButton(
                onPressed: () async {
                  if (pName.value.text.isNotEmpty &&
                      pNotification.value.text.isNotEmpty) {
                    Overlay.of(context)!.insert(loader);
                    int p = Random().nextInt(100);
                    await db
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .collection('reminder')
                        .add({
                      'medicine': pName.value.text,
                      'day': pDays.value.text,
                      'time': pNotification.value.text,
                      'quantity': pQuantity.value.text,
                      'time1': timeTable[sValue - 1],
                      'id': '$p'
                    }).then((value) {
                      scheduleAlarm(timeTile, p);
                      loader.remove();
                      Navigator.pop(context);
                    });
                  }
                },
                title: 'Done',
              )
            ],
          ),
        ),
      ),
    );
  }

  void scheduleAlarm(List d, int p) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Alarm found',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    // var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    //     sound: 'a_long_cold_sting.wav',
    //     presentAlert: true,
    //     presentBadge: true,
    //     presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOSPlatformChannelSpecifics
    );

    for (int i = 0; i < timeTile.length; i++) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          p,
          "Medicine Reminder",
          "${pName.value.text} . ${pQuantity.value.text}  pills . ${pDays.value.text} Days",
          tz.TZDateTime.parse(tz.local, timeTile[i]),
          const NotificationDetails(
              android: AndroidNotificationDetails('0', 'Healthcare',
                  importance: Importance.high, priority: Priority.high)),
          matchDateTimeComponents: DateTimeComponents.time,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }

    // await flutterLocalNotificationsPlugin.periodicallyShow(
    //     12,
    //     'Health Companion',
    //     'Did you get that?',
    //     RepeatInterval.everyMinute,
    //     platformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.cancelAll();
  }
}
