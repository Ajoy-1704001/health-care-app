import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/helper/shimmer_helper.dart';
import 'package:healthcare/screens/start_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:shimmer/shimmer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.isBack = false}) : super(key: key);
  final bool isBack;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Ajoy Deb Nath';
  String phone = '+8801858173457';
  double bmi = 21;
  double bmr = 32;
  String group = 'A+';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late String userId;

  TextEditingController pName = TextEditingController();
  TextEditingController pBlood = TextEditingController();
  TextEditingController pHeight = TextEditingController();
  TextEditingController pWeight = TextEditingController();
  TextEditingController pContact = TextEditingController();

  late OverlayEntry loader;
  ImagePicker picker = ImagePicker();
  late File _image;
  late bool permissionGranted;

  @override
  void initState() {
    super.initState();
    userId = auth.currentUser!.uid;
    print(userId);
    loader = Global.overlayLoader(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loader.dispose();
  }

  Future _getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("1");
      setState(() {
        permissionGranted = true;
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await per.openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      print("2");
      setState(() {
        permissionGranted = false;
      });
    }
  }

  Future imageSelect() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() async {
      if (pickedFile != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Uploading..."),
        ));
        _image = File(pickedFile.path);
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/' + auth.currentUser!.uid + '.jpg')
            .putFile(_image);
        await downloadURLExample();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Uploaded!!!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Nothing Selected"),
        ));
      }
    });
  }

  Future<void> downloadURLExample() async {
    String url = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/' + auth.currentUser!.uid + '.jpg')
        .getDownloadURL();
    await db.collection('users').doc(userId).update({'image': url});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
                stream: db.collection('users').doc(userId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double height =
                        double.parse(snapshot.data!.get('height')) / 100;
                    double bmi = double.parse(snapshot.data!.get('weight')) /
                        (height * height);

                    pName =
                        TextEditingController(text: snapshot.data!.get('name'));
                    pContact = TextEditingController(
                        text: snapshot.data!.get('em_contact'));
                    pWeight = TextEditingController(
                        text: snapshot.data!.get('weight'));
                    pHeight = TextEditingController(
                        text: snapshot.data!.get('height'));
                    pBlood = TextEditingController(
                        text: snapshot.data!.get('blood'));

                    return Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  decoration: BoxDecoration(
                                      color: MyTheme().secondary,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    bmi.toStringAsFixed(2),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    'BMI',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.get('weight')}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const Text('Weight(Kg)',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(children: [
                                                Text(
                                                  snapshot.data!.get('blood'),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text('Blood',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            widget.isBack
                                                ? IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: MyTheme().dark,
                                                    ))
                                                : Container(),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  auth.signOut().then((value) {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            PageRouteBuilder(
                                                                transitionsBuilder:
                                                                    (context,
                                                                        animation,
                                                                        secondary,
                                                                        child) {
                                                              return SlideTransition(
                                                                position: animation.drive(Tween(
                                                                    begin:
                                                                        const Offset(
                                                                            0.1,
                                                                            0.0),
                                                                    end: Offset
                                                                        .zero)),
                                                                child: child,
                                                              );
                                                            }, pageBuilder:
                                                                    (context,
                                                                        an,
                                                                        an2) {
                                                              return const StartScreen();
                                                            }),
                                                            (context) => false);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.logout_outlined,
                                                  color: MyTheme().dark,
                                                )),
                                          ],
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: imageSelect,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: snapshot.data!.get('image') == ''
                                          ? Image.asset(
                                              'images/photo.png',
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            )
                                          : Image.network(
                                              snapshot.data!.get('image'),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    snapshot.data!.get('name'),
                                    style: TextStyle(
                                        color: MyTheme().dark,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    snapshot.data!.get('email'),
                                    style: TextStyle(
                                        color: MyTheme().primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: MyTheme().dark),
                              ),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (pName.value.text.isNotEmpty &&
                                        pWeight.value.text.isNotEmpty &&
                                        pHeight.value.text.isNotEmpty &&
                                        pContact.value.text.isNotEmpty) {
                                      Overlay.of(context)!.insert(loader);
                                      await db
                                          .collection('users')
                                          .doc(userId)
                                          .update({
                                        'name': pName.value.text,
                                        'em_contact': pContact.value.text,
                                        'height': pHeight.value.text,
                                        'blood': pBlood.value.text,
                                        'weight': pWeight.value.text
                                      });
                                      loader.remove();
                                    }
                                  },
                                  child: const Text('Update'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              MyTheme().light)),
                                ),
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Profile Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  TextField(
                                    controller: pName,
                                    decoration: InputDecoration(
                                        hintText: 'Name',
                                        // prefixIcon: const Icon(
                                        //   Icons.,
                                        //   color: Colors.grey,
                                        // ),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Blood Group',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Height',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Weight',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: pBlood,
                                          readOnly: true,
                                          enabled: false,
                                          decoration: InputDecoration(
                                              hintText: 'Group',
                                              // prefixIcon: const Icon(
                                              //   Icons.,
                                              //   color: Colors.grey,
                                              // ),
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: pHeight,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'Height',
                                              // prefixIcon: const Icon(
                                              //   Icons.,
                                              //   color: Colors.grey,
                                              // ),
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: pWeight,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'Weight',
                                              // prefixIcon: const Icon(
                                              //   Icons.,
                                              //   color: Colors.grey,
                                              // ),
                                              filled: true,
                                              fillColor: Colors.grey.shade200,
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Emergency Contact',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  TextField(
                                    controller: pContact,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        hintText: 'Contact',
                                        // prefixIcon: const Icon(
                                        //   Icons.,
                                        //   color: Colors.grey,
                                        // ),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        isDense: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 30),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ShimmerHelper().buildBasicShimmer(
                              height: 100, width: double.infinity),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerHelper().buildBasicShimmer(
                              height: 100, width: double.infinity),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerHelper().buildBasicShimmer(
                            height: 100,
                            width: double.infinity,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerHelper().buildBasicShimmer(
                              height: 100, width: double.infinity),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerHelper().buildBasicShimmer(
                              height: 100, width: double.infinity),
                          const SizedBox(
                            height: 20,
                          ),
                          ShimmerHelper().buildBasicShimmer(
                              height: 100, width: double.infinity),
                        ],
                      ),
                    );
                  }
                })),
      ),
    );
  }
}
