import 'dart:math';

import 'package:fib/pin/pindisplay.dart';
import 'package:flutter/material.dart';

import 'keypad.dart';

class PinPad extends StatefulWidget {

   /// required PIN length.
  final int pinLength;

   /// decoration for the buttons on the KeyPad.
  final Decoration buttonDecoration;

  /// styles for the buttons on the KeyPad
  final TextStyle buttonTextStyle;

  /// decoration for the KeyPad.
  final Decoration keyPadDecoration;

  /// decoration for the PinPad Widget
  final Decoration decoration;

  /// PinPad padding.
  final EdgeInsetsGeometry padding;

  /// PinPad margin
  final EdgeInsetsGeometry margin;

  /// PinPad title. Defaults to Text("Enter PIN")
  final Widget title;

  /// to mask PIN or not. default is true.
  final bool maskInput;

  /// to scramble the position of input keys.
  final bool scrambleKeys;

  const PinPad(
      {super.key, this.pinLength = 4,
      this.maskInput = true,
      this.scrambleKeys=true,
      this.padding = const EdgeInsets.all(5.0),
      this.margin = const EdgeInsets.all(5.0),
      this.decoration = const BoxDecoration(),
      this.keyPadDecoration = const BoxDecoration(),
      this.buttonDecoration = const BoxDecoration(),
      this.buttonTextStyle = const TextStyle(),
      required this.title});

  @override
  _PinPadState createState() => _PinPadState();

  factory PinPad.useDefault() {
    return const PinPad(title: Text("Enter PIN"));
  }
}

class _PinPadState extends State<PinPad> {
  List<int> _values=[];
  String _input = "";

  @override
  initState(){
    super.initState();
    _values = InputHelper.getNumbers(widget.scrambleKeys);
  }

  void addValue(String value) {
    setState(() {
      if (_input.isEmpty) {
        _input = value;
      } else {
        _input += value;
        if (_input.length == widget.pinLength) {
          Navigator.of(context).pop(_input);
        }
      }
    });
  }

  void remove(dynamic) {
    setState(() {
      if (_input.isEmpty) {
        _input = "";
      } else {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void clear(dynamic) {
    setState(() {
      _input = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: widget.padding,
          margin: widget.margin,
          decoration: widget.decoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              widget.title,
              Container(height: 40.0),
              PinDisplay(widget.pinLength, _input, widget.maskInput,null,null,null),
              Container(
                height: 10.0,
              ),
              KeyPad(
                  _values,
                  this.addValue,
                  this.remove,
                  this.clear,
                  widget.scrambleKeys,
                  widget.keyPadDecoration,
                  widget.buttonDecoration,
                  widget.buttonTextStyle)
            ],
          ),
        ),
      ),
    );
  }
}

class InputHelper {
  static List<int> getNumbers(bool scrambleNumbers) {
    var numberSet = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

    if(!scrambleNumbers){
      return numberSet;
    }

    List<int> randomSet = [];

    var random = Random();

    while (numberSet.isNotEmpty) {
      var randomIndex = random.nextInt(numberSet.length);
      var selectedEntry = numberSet[randomIndex];
      randomSet.add(selectedEntry);
      numberSet.removeAt(randomIndex);
    }

    return randomSet;
  }
}
