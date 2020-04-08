import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:challenge_wolf/ui/utils/utils.dart';

class HomeStyles with Sizes {
  TextStyle saveButtonTitle;

  TextStyle forgetButtonTitle;

  HomeStyles(BuildContext context) {
    setDefaultSize(context);

    saveButtonTitle = TextStyle(
      fontFamily: 'roboto',
      color: Colors.black,
      fontSize: super.sizeP(20),
      //height: sizeH(0.5),
      fontWeight: FontWeight.w600,
    );

    forgetButtonTitle = TextStyle(
      fontFamily: 'Arial',
      color: Colors.red,
      fontSize: super.sizeP(16),
      //height: sizeH(0.5),
      fontWeight: FontWeight.w600,
    );
  }
}