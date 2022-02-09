import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/shimmer_helper.dart';
import 'package:healthcare/screens/add_pill_reminder.dart';
import 'package:healthcare/widgets/pill_widget.dart';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({Key? key}) : super(key: key);

  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).padding.top,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.top,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 18, left: 50),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Medicine Reminder',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Review',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: MyTheme().dark),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(transitionsBuilder:
                            (context, animation, secondary, child) {
                          // return ScaleTransition(
                          //     alignment: Alignment.center,
                          //     child: child,
                          //     scale: Tween<double>(begin: 0.1, end: 1)
                          //         .animate(CurvedAnimation(
                          //             parent: animation,
                          //             curve: Curves.bounceIn)));
                          return SlideTransition(
                            position: animation.drive(Tween(
                                begin: const Offset(0.0, 0.1),
                                end: Offset.zero)),
                            child: child,
                          );
                        }, pageBuilder: (context, an, an2) {
                          return const AddPill();
                        }));
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Reminder',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                )
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .collection('reminder')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Pill(
                            pillName:
                                snapshot.data!.docs[index].get('medicine'),
                            time: snapshot.data!.docs[index].get('time'),
                            time1: snapshot.data!.docs[index].get('time1'),
                            onPress: () async {
                              await db
                                  .collection('users')
                                  .doc(auth.currentUser!.uid)
                                  .collection('reminder')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete()
                                  .then((value) async {
                                await flutterLocalNotificationsPlugin.cancel(
                                    int.parse(
                                        snapshot.data!.docs[index].get('id')));
                              });
                            },
                          ),
                        );
                      });
                } else {
                  return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ShimmerHelper()
                            .buildListShimmer(item_count: 6, item_height: 50)),
                  );
                }
              })
        ],
      ),
    );
  }
}
