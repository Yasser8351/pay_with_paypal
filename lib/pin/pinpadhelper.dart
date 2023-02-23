import 'dart:async';

import 'package:fib/pin/pinpad.dart';
import 'package:flutter/material.dart';

class PinPadHelper {

  /// pops up a pinpad widget. uses PinPad.useDefault() if no pinpad object is passed.
  static Future<String> requestPin({required BuildContext context, PinPad? pinpad}) async {

    var result = await Navigator.of(context).push(new MaterialPageRoute<String>(
        builder: (ctx) => pinpad ?? PinPad.useDefault(),
        fullscreenDialog: true));
    return result!;
  }
}
