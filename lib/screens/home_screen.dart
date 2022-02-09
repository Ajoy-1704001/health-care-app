import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/shared_value_helper.dart';
import 'package:healthcare/helper/shimmer_helper.dart';
import 'package:healthcare/screens/appoinment_screen.dart';
import 'package:healthcare/screens/appointment_edit.dart';
import 'package:healthcare/screens/profile_screen.dart';
import 'package:healthcare/widgets/checklist.dart';
import 'package:healthcare/widgets/mini_solid_button.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: MyTheme().transparent,
              height: kToolbarHeight,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: MyTheme().transparent,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 4),
                          child: Text(
                            'Good ${greeting()}',
                            style: TextStyle(
                                color: MyTheme().dark,
                                fontSize: 21,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '${user_name.value.substring(0, user_name.value.indexOf(' '))}',
                            style: TextStyle(
                                color: MyTheme().dark,
                                fontSize: 21,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 70),
                          child: Text(
                            'Your target for today is to keep positive mindset and smile to everyone you meet.',
                            style: TextStyle(
                                color: MyTheme().secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            // MiniSolidButton(
                            //     fontSize: 13,
                            //     callback: () {},
                            //     label: 'MIND TEST',
                            //     backgroundColor: MyTheme().primary),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            MiniSolidButton(
                                fontSize: 13,
                                callback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen(
                                                isBack: true,
                                              )));
                                },
                                label: 'SEE YOUR PROFILE',
                                backgroundColor: MyTheme().dark)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white,
                        width: 44,
                        height: 44,
                      )),
                ),
                Positioned(
                  right: 20,
                  top: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: user_image.value == ''
                        ? Image.asset(
                            'images/photo.png',
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          )
                        : Image.network(
                            user_image.value,
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are you doing today?',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MyTheme().dark),
                  ),
                  const CheckList(
                    title: 'Exercise',
                    subtitle: 'Physical Activity for Fitness',
                    iconData: LineIcons.running,
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                  ),
                  const CheckList(
                    title: 'Drink Water',
                    subtitle: 'Daily Drink Water Upto 2 Littres',
                    iconData: LineIcons.running,
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointments',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: MyTheme().dark),
                      ),
                      TextButton.icon(
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
                                  return const Appointment();
                                }));
                          },
                          icon: Icon(
                            Icons.add,
                            size: 19,
                            color: MyTheme().primary,
                          ),
                          label: Text(
                            'Schedule',
                            style: TextStyle(
                                color: MyTheme().primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection('users')
                          .doc(auth.currentUser!.uid)
                          .collection('appointment')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(transitionsBuilder:
                                            (context, animation, secondary,
                                                child) {
                                          return SlideTransition(
                                            position: animation.drive(Tween(
                                                begin: const Offset(0.0, 0.1),
                                                end: Offset.zero)),
                                            child: child,
                                          );
                                        }, pageBuilder: (context, an, an2) {
                                          return AppointmentEdit(
                                            Id: snapshot.data!.docs[index].id,
                                          );
                                        }));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.medical_services,
                                        size: 40,
                                        color: MyTheme().dark,
                                      ),
                                      Container(),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data!.docs[index]
                                                .get('appointment'),
                                            style: TextStyle(
                                                color: MyTheme().dark,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          subtitle: Text(
                                            '${snapshot.data!.docs[index].get('date')} || ${snapshot.data!.docs[index].get('time')}',
                                            style: TextStyle(
                                                color: MyTheme().subtitle,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 20,
                                          width: 65,
                                          child: IconButton(
                                              onPressed: () async {
                                                await db
                                                    .collection('users')
                                                    .doc(auth.currentUser!.uid)
                                                    .collection('appointment')
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete()
                                                    .then((value) {
                                                  print(snapshot
                                                      .data!.docs[index].id);
                                                });
                                                setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: MyTheme().dark,
                                              )))
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: ShimmerHelper().buildListShimmer(
                                  item_count: 3, item_height: 30));
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
