import 'dart:ui';

import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/utils/utils.dart';
import 'package:challenge_wolf/ui/widgets/url_launch_html.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FilePickerButton extends StatefulWidget {
  final String label;
  final HomeStyles styles;
  final double width;
  final String description;
  final String customRequirementId;
  final String value;

  const FilePickerButton(
      {Key key,
      @required this.label,
      @required this.styles,
      @required this.width,
      @required this.description,
      @required this.customRequirementId,
      @required this.value})
      : super(key: key);

  @override
  _FilePickerButtonState createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  String pathFile = "";
  TextEditingController filePickerValue;

  @override
  void initState() {
    filePickerValue =
        TextEditingController(text: widget.value ?? "Select File");
    super.initState();
  }

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

            if (path != null) {
              setState(() {
                pathFile = path;
                filePickerValue.text = UtilsRegex.pathVerification(pathFile);
              });
            }
          },
          child: Container(
            width: widget.width,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.styles.sizeW(5)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(
              bottom: widget.styles.sizeH(15),
            ),
            child: FormBuilderTextField(
              attribute: widget.customRequirementId,
              readOnly: true,
              controller: filePickerValue,
              valueTransformer: (v) {
                if (v == "Select File") {
                  setState(() {
                    filePickerValue.text = "";
                  });
                } else
                  return v;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(
                  widget.styles.sizeW(20),
                  widget.styles.sizeH(2),
                  widget.styles.sizeW(20),
                  widget.styles.sizeH(2),
                ),
                labelText: widget.label,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                errorStyle: TextStyle(
                  color: Colors.red[800],
                ),
                hintText: "Select File",
                hintStyle: TextStyle(
                  fontSize: widget.styles.sizeH(5),
                  fontWeight: FontWeight.w800,
                ),
              ),
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
          ),
        ),
        UrlLaunchHtml(
          description: widget.description,
          styles: widget.styles,
        ),
      ],
    );
  }
}
