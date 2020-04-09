import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class SaveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final HomeStyles styles;
  final double width;
  final double heigth;
  final String description;

  const SaveButton({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.styles,
    @required this.width,
    @required this.heigth,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: width,
          height: heigth,
          margin: EdgeInsets.only(
            bottom: styles.sizeH(15),
          ),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(styles.sizeW(40.0)),
            ),
            onPressed: () => onPressed(),
            child: Text(
              label,
              style: styles.saveButtonTitle,
            ),
          ),
        ),
        Html(
          data: description,
          defaultTextStyle: styles.linkText,
          customTextAlign: (_) => TextAlign.center,
          onLinkTap: (url) async => await launch(Url.verification(url)),
        )
      ],
    );
  }
}
