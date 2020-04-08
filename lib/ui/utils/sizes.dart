import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin Sizes {
  void setDefaultSize(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 360,
      height: 740,
      allowFontScaling: true,
    );
  }

  double sizeW(double width) => ScreenUtil().setWidth(width);

  double sizeH(double height) => ScreenUtil().setHeight(height);

  double sizeP(double size) => ScreenUtil().setSp(size);
}