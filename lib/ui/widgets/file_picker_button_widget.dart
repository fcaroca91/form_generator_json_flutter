import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/utils/utils.dart';
import 'package:challenge_wolf/ui/widgets/url_launch_html.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class FilePickerButton extends StatelessWidget {
  final String label;
  final HomeStyles styles;
  final double width;
  final double heigth;
  final InputDecoration decoration;
  final String description;

  const FilePickerButton({
    Key key,
    @required this.label,
    @required this.styles,
    @required this.width,
    @required this.heigth,
    @required this.decoration,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            String path = await FilePicker.getFilePath(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            print("WENA:  ${path ?? 'No seleccionaste nada'}");
          },
          child: Container(
            width: width,
            //height: heigth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(5) //         <--- border radius here
                  ),
            ),
            margin: EdgeInsets.only(
              bottom: styles.sizeH(15),
            ),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'jgcvjhgkh',
                hintText: 'You cannot focus me',
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: styles.sizeH(15),
          ),
          child: UrlLaunchHtml(
            description: description,
            styles: styles,
          ),
        ),
      ],
    );
  }
}
