import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image;
  final styles;
  final double widthButton;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.styles,
    this.widthButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(styles.sizeH(16.0)),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: styles.sizeH(84.0),
              bottom: styles.sizeH(16.0),
              left: styles.sizeH(16.0),
              right: styles.sizeH(16.0),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(styles.sizeH(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  "assets/images/sin_internet.png",
                  height: styles.sizeH(181.0),
                ),
                SizedBox(height: styles.sizeH(35.0)),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xff363636),
                    fontSize: styles.sizeH(16.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: styles.sizeH(19.0)),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff7f7f7f),
                    fontSize: styles.sizeH(16.0),
                  ),
                ),
                SizedBox(height: styles.sizeH(35.0)),
                Align(alignment: Alignment.bottomCenter, child: null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
