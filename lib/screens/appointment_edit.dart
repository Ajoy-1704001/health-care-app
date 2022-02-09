import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/widgets/gradient_button.dart';
import 'package:line_icons/line_icons.dart';

class AppointmentEdit extends StatefulWidget {
  const AppointmentEdit({Key? key, required this.Id}) : super(key: key);
  final String Id;

  @override
  _AppointmentEditState createState() => _AppointmentEditState();
}

class _AppointmentEditState extends State<AppointmentEdit> {
  TextEditingController pName = TextEditingController();
  TextEditingController pMotive = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  TextEditingController timeCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  late OverlayEntry loader;
  late String time;
  late String date;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader = Global.overlayLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: StreamBuilder<DocumentSnapshot>(
              stream: db
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .collection('appointment')
                  .doc(widget.Id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  pName.text = snapshot.data!.get('appointment');
                  pMotive.text = snapshot.data!.get('description');
                  place.text = snapshot.data!.get('location');
                  doctorName.text = snapshot.data!.get('doctorName');
                  timeCon.text = snapshot.data!.get('time');
                  dateCon.text = snapshot.data!.get('date');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
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
                                'Add Appointment',
                                style: TextStyle(
                                    color: MyTheme().dark,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Appointment Name',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: pName,
                                decoration: InputDecoration(
                                    hintText: 'Appoinment Name',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Reason',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: pMotive,
                                decoration: InputDecoration(
                                    hintText: 'Description',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Location',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: place,
                                decoration: InputDecoration(
                                    hintText: 'Location',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Doctor Name',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: doctorName,
                                decoration: InputDecoration(
                                    hintText: 'Doctor Name',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Date',
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
                                      controller: dateCon,
                                      readOnly: true,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: 'Date',
                                          prefixIcon: const Icon(
                                            LineIcons.calculator,
                                            color: Colors.grey,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          isDense: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15))),
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
                                            final DateTime? newDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2017, 1),
                                              lastDate: DateTime(2022, 7),
                                              helpText: 'Select a date',
                                            );
                                            if (newDate != null) {
                                              setState(() {
                                                dateCon.text = newDate
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        newDate
                                                            .toString()
                                                            .indexOf(' '));

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
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Time',
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
                                      controller: timeCon,
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
                                              borderRadius:
                                                  BorderRadius.circular(15))),
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
                                                  minute:
                                                      DateTime.now().minute),
                                            );
                                            if (newTime != null) {
                                              setState(() {
                                                timeCon.text =
                                                    newTime.format(context);
                                                String d = DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        DateTime.now().day,
                                                        newTime.hour,
                                                        newTime.minute)
                                                    .toString();
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
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      GradientButton(
                        onPressed: () async {
                          if (pName.value.text.isNotEmpty &&
                              place.value.text.isNotEmpty &&
                              dateCon.value.text.isNotEmpty &&
                              timeCon.value.text.isNotEmpty) {
                            Overlay.of(context)!.insert(loader);
                            await db
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .collection('appointment')
                                .add({
                              'appointment': pName.value.text,
                              'date': dateCon.value.text,
                              'time': timeCon.value.text,
                              'description': pMotive.value.text,
                              'doctorName': doctorName.value.text,
                              'location': place.value.text
                            }).then((value) {
                              loader.remove();
                              Navigator.pop(context);
                            });
                          }
                        },
                        title: 'Done',
                      )
                    ],
                  );
                } else {
                  return Column(
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
                                'Add Appointment',
                                style: TextStyle(
                                    color: MyTheme().dark,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Appointment Name',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: pName,
                                decoration: InputDecoration(
                                    hintText: 'Appoinment Name',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Reason',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: pMotive,
                                decoration: InputDecoration(
                                    hintText: 'Description',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Location',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: place,
                                decoration: InputDecoration(
                                    hintText: 'Location',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Doctor Name',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextField(
                                controller: doctorName,
                                decoration: InputDecoration(
                                    hintText: 'Doctor Name',
                                    prefixIcon: const Icon(
                                      LineIcons.pills,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Date',
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
                                      controller: dateCon,
                                      readOnly: true,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: 'Date',
                                          prefixIcon: const Icon(
                                            LineIcons.calculator,
                                            color: Colors.grey,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          isDense: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(15))),
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
                                            final DateTime? newDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2017, 1),
                                              lastDate: DateTime(2022, 7),
                                              helpText: 'Select a date',
                                            );
                                            if (newDate != null) {
                                              setState(() {
                                                dateCon.text = newDate
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        newDate
                                                            .toString()
                                                            .indexOf(' '));

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
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Time',
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
                                      controller: timeCon,
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
                                              borderRadius:
                                                  BorderRadius.circular(15))),
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
                                                  minute:
                                                      DateTime.now().minute),
                                            );
                                            if (newTime != null) {
                                              setState(() {
                                                timeCon.text =
                                                    newTime.format(context);
                                                String d = DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        DateTime.now().day,
                                                        newTime.hour,
                                                        newTime.minute)
                                                    .toString();
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
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      GradientButton(
                        onPressed: () async {
                          if (pName.value.text.isNotEmpty &&
                              place.value.text.isNotEmpty &&
                              dateCon.value.text.isNotEmpty &&
                              timeCon.value.text.isNotEmpty) {
                            Overlay.of(context)!.insert(loader);

                            await db
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .collection('appointment')
                                .doc(widget.Id)
                                .update({
                              'appointment': pName.value.text,
                              'date': dateCon.value.text,
                              'time': timeCon.value.text,
                              'description': pMotive.value.text,
                              'doctorName': doctorName.value.text,
                              'location': place.value.text
                            }).then((value) {
                              loader.remove();
                              Navigator.pop(context);
                            });
                          }
                        },
                        title: 'Done',
                      )
                    ],
                  );
                }
              })),
    );
  }
}
