import 'package:fib/screen/success_screen.dart';
import 'package:fib/widgets/fib_button.dart';
import 'package:fib/pin/pinpadhelper.dart';
import 'package:fib/widgets/text_faild_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> expDateList = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  List<String> expYearList = [
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030'
  ];

  String? _expDateSelected;
  String? _expYearSelected;
  TextEditingController cardNumbercontroller = TextEditingController();
  TextEditingController pinController = TextEditingController();
  bool isLoading = false;

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    super.initState();
    secureScreen();
  }

  Future _getPin() async {
    var pin = await PinPadHelper.requestPin(context: context);
    setState(() {
      pinController.text = pin;
      validationPay();
    });
  }

  validationPay() {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (cardNumbercontroller.text.isEmpty ||
        cardNumbercontroller.text.length > 16) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please Enter Card Number")));
    }
    if (_expDateSelected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please Enter Month")));
    }
    if (_expYearSelected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please Enter Year")));
    }
    if (pinController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("please Enter PIN")));
    }
    if (pinController.text.length == 4 &&
            cardNumbercontroller.text.length == 16 ||
        cardNumbercontroller.text.length == 19 &&
            _expDateSelected != null &&
            _expYearSelected != null) {
      isLoading = true;
      Future.delayed(const Duration(seconds: 5)).then((value) => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SuccessScreen(),
            ))
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('FIB Payment'),
        backgroundColor: kcPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFaildWidget(
                    controller: cardNumbercontroller,
                    label: "Enter Card Number",
                    maxLength: 19,
                    inputType: TextInputType.number),
                const SizedBox(height: 20),
                const Text("ExpDate"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildDropdown(expDateList, _expDateSelected,
                        onChanged: (value) {
                      setState(() {
                        _expDateSelected = value;
                      });
                    }, hint: "month"),
                    const SizedBox(width: 40),
                    buildDropdown(expYearList, _expYearSelected,
                        onChanged: (value) {
                      setState(() {
                        _expYearSelected = value;
                      });
                    }, hint: "Year"),
                  ],
                ),
                const SizedBox(height: 25),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus && pinController.text.length != 4) {
                      _getPin();
                    }
                  },
                  child: TextFaildWidget(
                    controller: pinController,
                    label: "Enter PIN",
                    prefixIcon: CupertinoIcons.eye_slash_fill,
                    isPrefixIcon: true,
                    obscure: true,
                    maxLength: 4,
                  ),
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      busy: isLoading,
                      text: "Pay",
                      width: 100,
                      onTap: () {
                        setState(() => validationPay());
                      },
                    ),
                    const SizedBox(width: 10),
                    MyButton(
                      text: "Cancel",
                      width: 100,
                      onTap: () => setState(() => isLoading = false),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

buildDropdown(List<String> expDateList, String? valueSelected,
    {required Function(String value) onChanged, String hint = ''}) {
  return Container(
    width: 100,
    decoration: BoxDecoration(
      // color: kcGreyVeryLight,
      border: Border.all(
        width: 1,
        // color: _genderController.text.isEmpty && firstTap
        //     ? Colors.red
        //     : Colors.grey.shade300,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey[350]),
          ),
          onChanged: (value) {
            onChanged(value!);
          },
          // style: TextStyle(
          //     color: Theme.of(context).colorScheme.primary),
          value: valueSelected,
          isExpanded: true,
          iconSize: 28,
          // icon: ImageSVG(
          //   image: AppSVG.arrow_down,
          //   color: Colors.black,
          //   width: 12,
          //   height: 12,
          // ),

          items: expDateList
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.toString(),
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
