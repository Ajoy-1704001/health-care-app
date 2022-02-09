import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/helper/global.dart';
import 'package:healthcare/screens/main_screen.dart';
import 'package:healthcare/widgets/gradient_button.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String dropdownValue = 'none';
  bool _obscure = true;
  Color eye = Colors.grey;
  late OverlayEntry loader;

  late String email;
  late String pass;
  late String name;
  late String height;
  late String weight;
  late String blood;
  late String age;
  late String contact;

  @override
  void initState() {
    super.initState();
    loader = Global.overlayLoader(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loader.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/plus.png',
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text('Create Account',
                      style: TextStyle(
                          color: MyTheme().dark,
                          fontSize: 18,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                      key: _key,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            child: Material(
                              shadowColor: MyTheme().light,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: TextFormField(
                                onSaved: (value) {
                                  name = value!;
                                },
                                validator: (value) => value == ''
                                    ? 'Please enter your name'
                                    : null,
                                // controller: emailCon,
                                // keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    prefixIcon: const Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            child: Material(
                              shadowColor: MyTheme().light,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: TextFormField(
                                // controller: emailCon,
                                onSaved: (value) {
                                  email = value!;
                                },
                                validator: (value) => value!.contains('@')
                                    ? null
                                    : 'Enter a valid email',
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      shadowColor: MyTheme().light,
                                      borderRadius: BorderRadius.circular(15),
                                      elevation: 5,
                                      child: TextFormField(
                                        // controller: emailCon,
                                        onSaved: (value) {
                                          height = value!;
                                        },
                                        validator: (value) => value == ''
                                            ? 'Please enter your height'
                                            : null,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Height',
                                            prefixIcon: const Icon(
                                              Icons.height,
                                              color: Colors.grey,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            isDense: true,
                                            suffixText: 'cm',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  Expanded(
                                    child: Material(
                                      shadowColor: MyTheme().light,
                                      borderRadius: BorderRadius.circular(15),
                                      elevation: 5,
                                      child: TextFormField(
                                        // controller: emailCon,
                                        onSaved: (value) {
                                          age = value!;
                                        },
                                        validator: (value) => value == ''
                                            ? 'Please enter your age'
                                            : null,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Age',
                                            prefixIcon: const Icon(
                                              Icons.ac_unit,
                                              color: Colors.grey,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            isDense: true,
                                            suffixText: 'years',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 20),
                            child: Material(
                              shadowColor: MyTheme().light,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: TextFormField(
                                // controller: emailCon,
                                onSaved: (value) {
                                  weight = value!;
                                },
                                validator: (value) => value == ''
                                    ? 'Please enter your weight'
                                    : null,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Weight',
                                    prefixIcon: const Icon(
                                      Icons.monitor_weight,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    suffixText: 'Kg',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      shadowColor: MyTheme().light,
                                      borderRadius: BorderRadius.circular(15),
                                      elevation: 5,
                                      child: TextFormField(
                                        // controller: emailCon,
                                        onSaved: (value) {
                                          contact = value!;
                                        },
                                        validator: (value) => value == ''
                                            ? 'Must enter your emergency contact'
                                            : null,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintText: 'Emergency Contact',
                                            prefixIcon: const Icon(
                                              Icons.height,
                                              color: Colors.grey,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Material(
                                      shadowColor: MyTheme().light,
                                      borderRadius: BorderRadius.circular(15),
                                      elevation: 5,
                                      child: Container(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: DropdownButton<dynamic>(
                                            underline: Container(),
                                            isExpanded: true,
                                            value: dropdownValue,
                                            items: const <DropdownMenuItem>[
                                              DropdownMenuItem(
                                                value: 'none',
                                                child: Text('Group'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'A+',
                                                child: Text('A+'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'A-',
                                                child: Text('A-'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'B+',
                                                child: Text('B+'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'B-',
                                                child: Text('B-'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'AB+',
                                                child: Text('AB+'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'AB-',
                                                child: Text('AB+'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'O+',
                                                child: Text('O+'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'O-',
                                                child: Text('O-'),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                dropdownValue = value;
                                              });
                                            },
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Material(
                              shadowColor: MyTheme().light,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 5,
                              child: TextFormField(
                                onSaved: (value) {
                                  pass = value!;
                                },
                                validator: (value) => value == ''
                                    ? 'Please enter a password'
                                    : null,
                                obscureText: _obscure,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscure = !_obscure;
                                            if (_obscure) {
                                              eye = Colors.grey;
                                            } else {
                                              eye = Colors.green;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: eye,
                                        )),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: GradientButton(
                        title: 'Sign Up',
                        onPressed: () async {
                          if (_key.currentState!.validate() &&
                              dropdownValue != 'none') {
                            Overlay.of(context)!.insert(loader);
                            _key.currentState!.save();
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: pass);
                              firestore
                                  .collection('users')
                                  .doc(userCredential.user!.uid)
                                  .set({
                                'name': name,
                                'email': email,
                                'em_contact': contact,
                                'age': age,
                                'height': height,
                                'blood': dropdownValue,
                                'weight': weight,
                                'image': ''
                              }).then((value) {
                                loader.remove();
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
                                      return const MainScreen();
                                    }),
                                    (context) => false);
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                                showToast(
                                  'The password provided is too weak',
                                  context: context,
                                  animation:
                                      StyledToastAnimation.slideFromBottom,
                                );
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                                showToast(
                                  'The account already exists for that email',
                                  context: context,
                                  animation:
                                      StyledToastAnimation.slideFromBottom,
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyTheme().dark,
                    )),
              ),
            )
          ],
        ));
  }
}
