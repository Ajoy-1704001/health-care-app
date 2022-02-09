import 'package:flutter/material.dart';
import 'package:healthcare/helper/color_helper.dart';
import 'package:healthcare/widgets/gradient_button.dart';

class HeartDisease extends StatefulWidget {
  const HeartDisease({Key? key}) : super(key: key);

  @override
  _HeartDiseaseState createState() => _HeartDiseaseState();
}

class _HeartDiseaseState extends State<HeartDisease> {
  TextEditingController oldPeak = TextEditingController();
  List<double> input = [];
  List ecg = [
    'Normal',
    'ST-T wave abnormality',
    'Probable or definite left ventricular hypertrophy'
  ];
  List gender = ['Female', 'Male'];
  List fans = ['No', 'Yes'];
  double age = 20;
  double pain = 2;
  double rbp = 130;
  double cholesterol = 300;
  double hrate = 100;
  double slope = 2;
  int exercise = 0;
  int recg = 0;
  int sex = 0;
  int fbs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 40),
            child: Text(
              'Heart Disease Checker',
              style: TextStyle(
                  color: MyTheme().dark,
                  fontWeight: FontWeight.w800,
                  fontSize: 15),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Sex',
                      style: TextStyle(
                          fontSize: 14,
                          color: MyTheme().dark,
                          fontWeight: FontWeight.w600),
                    ),
                    for (int i = 0; i <= 1; i++)
                      ListTile(
                        minVerticalPadding: 0,
                        dense: true,
                        title: Text(
                          gender[i],
                          // style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == 2 ? Colors.black38 : shrineBrown900),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: sex,
                          onChanged: (int? value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                        ),
                      ),
                    Row(
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${age.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: age,
                      min: 1,
                      max: 120,
                      divisions: 118,
                      label: age.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Heart Pain (1 to 4)',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${pain.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: pain,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: pain.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          pain = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Resting Blood Pressure',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${rbp.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: rbp,
                      min: 0,
                      max: 200,
                      divisions: 200,
                      label: rbp.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          rbp = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Max Heart Rate',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${hrate.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: hrate,
                      min: 50,
                      max: 250,
                      divisions: 200,
                      label: hrate.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          hrate = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'Cholesterol',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${cholesterol.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: cholesterol,
                      min: 0,
                      max: 1000,
                      divisions: 1000,
                      label: cholesterol.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          cholesterol = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          'ST Slope',
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme().dark,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text('${slope.round()}',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyTheme().dark,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    Slider(
                      value: slope,
                      min: 0,
                      max: 3,
                      divisions: 3,
                      label: slope.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          slope = value;
                        });
                      },
                    ),
                    Text(
                      'Resting electrocardiographic result',
                      style: TextStyle(
                          fontSize: 14,
                          color: MyTheme().dark,
                          fontWeight: FontWeight.w600),
                    ),
                    for (int i = 0; i <= 2; i++)
                      ListTile(
                        minVerticalPadding: 0,
                        dense: true,
                        title: Text(
                          ecg[i],
                          // style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == 2 ? Colors.black38 : shrineBrown900),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: recg,
                          onChanged: (int? value) {
                            setState(() {
                              recg = value!;
                            });
                          },
                        ),
                      ),
                    Text(
                      'Fasting Blood Sugar > 120 mg/dl)',
                      style: TextStyle(
                          fontSize: 14,
                          color: MyTheme().dark,
                          fontWeight: FontWeight.w600),
                    ),
                    for (int i = 0; i <= 1; i++)
                      ListTile(
                        minVerticalPadding: 0,
                        dense: true,
                        title: Text(
                          fans[i],
                          // style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == 2 ? Colors.black38 : shrineBrown900),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: fbs,
                          onChanged: (int? value) {
                            setState(() {
                              fbs = value!;
                            });
                          },
                        ),
                      ),
                    Text(
                      'Exercise induced angina',
                      style: TextStyle(
                          fontSize: 14,
                          color: MyTheme().dark,
                          fontWeight: FontWeight.w600),
                    ),
                    for (int i = 0; i <= 1; i++)
                      ListTile(
                        minVerticalPadding: 0,
                        dense: true,
                        title: Text(
                          fans[i],
                          // style: Theme.of(context).textTheme.subtitle1!.copyWith(color: i == 2 ? Colors.black38 : shrineBrown900),
                        ),
                        leading: Radio(
                          value: i,
                          groupValue: exercise,
                          onChanged: (int? value) {
                            setState(() {
                              exercise = value!;
                            });
                          },
                        ),
                      ),
                    TextField(
                      controller: oldPeak,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Old Peak Value',
                          // prefixIcon: const Icon(
                          //   LineIcons.calculator,
                          //   color: Colors.grey,
                          // ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
            child: GradientButton(
                title: 'Check',
                onPressed: () {
                  input = [
                    age,
                    sex.toDouble(),
                    pain,
                    rbp,
                    cholesterol,
                    fbs.toDouble(),
                    recg.toDouble(),
                    hrate,
                    exercise.toDouble(),
                    double.parse(oldPeak.value.text),
                    slope
                  ];
                  double result = score(input);

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Result Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyTheme().primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          content: Wrap(
                            children: [
                              result.toInt() == 1
                                  ? Text(
                                      'It Seems that you might have heart disease. Please contact to your doctor immediately',
                                      textAlign: TextAlign.center,
                                    )
                                  : Text('Your Heart seems to be working fine',
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
                }),
          )
        ],
      ),
    );
  }

  double score(List<double> input) {
    return (((((((((((-0.2108882736111798) +
                                                ((input[0]) *
                                                    (-0.017807733278147993))) +
                                            ((input[1]) *
                                                (1.0734952816933372))) +
                                        ((input[2]) * (0.6008182024668962))) +
                                    ((input[3]) * (-0.004086546586174185))) +
                                ((input[4]) * (-0.0032657726945494276))) +
                            ((input[5]) * (0.8218727756328955))) +
                        ((input[6]) * (0.20966686726381875))) +
                    ((input[7]) * (-0.022515884082948995))) +
                ((input[8]) * (0.9182121759956032))) +
            ((input[9]) * (0.44313456244595395))) +
        ((input[10]) * (1.20212632559324));
  }
}
