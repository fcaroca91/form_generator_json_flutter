import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/widgets/url_launch_html.dart';

import 'package:challenge_wolf/ui/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';

import 'package:challenge_wolf/core/models/custom_requirement_model.dart';

class JsonCustomRequirementsComponents extends StatelessWidget {
  final Widget buttonSave;
  final Function actionSave;
  final ValueChanged<dynamic> onChanged;
  final CustomRequirement customRequirement;
  final HomeStyles styles;

  JsonCustomRequirementsComponents({
    @required this.onChanged,
    this.buttonSave,
    this.actionSave,
    @required this.customRequirement,
    @required this.styles,
  });

  @override
  Widget build(BuildContext context) {
    final String labelText = customRequirement.question;

    final String description = customRequirement.description;

    final String attribute = customRequirement.customRequirementId.toString();

    final double width = styles.sizeW(300);
    final double height = styles.sizeW(70);

    final InputDecoration inputDecoration = InputDecoration(
      labelText: labelText,
      labelStyle: styles.textFormField,
      helperText: "",
      //helperText: description,
      /* errorStyle: TextStyle(
        color: Colors.red,
        fontSize: styles.sizeH(10.0),
      ), */
      contentPadding: EdgeInsets.fromLTRB(
        styles.sizeW(20),
        styles.sizeH(15),
        styles.sizeW(20),
        styles.sizeH(0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          styles.sizeW(5),
        ),
      ),
    );

    final EdgeInsets margin = EdgeInsets.only(
      top: styles.sizeH(20),
      bottom: styles.sizeH(0),
    );

    String helperText = description;

    switch (customRequirement.fieldType) {
      case "Freetext":
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height,
              margin: margin,
              child: FormBuilderTextField(
                attribute: attribute,
                decoration: inputDecoration,
                validators: [
                  FormBuilderValidators.required(),
                ],
                keyboardType: TextInputType.text,
              ),
            ),
            Positioned(
              top: styles.sizeH(68),
              child: UrlLaunchHtml(
                description: description,
                styles: styles,
              ),
            )
          ],
        );
        break;
      case "Integer":
        return Container(
          width: width,
          height: height,
          margin: margin,
          child: FormBuilderTextField(
            attribute: attribute,
            decoration: inputDecoration,
            valueTransformer: (text) => num.tryParse(text),
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ],
            keyboardType: TextInputType.number,
          ),
        );
        break;
      case "Dropdown":
        return Container(
          width: width,
          height: height,
          margin: margin,
          child: FormBuilderDropdown(
            attribute: attribute,
            decoration: inputDecoration,
            hint: Text('Select Value'),
            validators: [
              FormBuilderValidators.required(),
            ],
            items: customRequirement.options
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text('$value'),
                    ))
                .toList(),
          ),
        );
        break;
      case "Checkbox":
        return Container(
          width: width,
          margin: EdgeInsets.only(bottom: styles.sizeH(25)),
          child: FormBuilderCheckboxList(
            attribute: 'checkBox',
            decoration: inputDecoration,
            //initialValue: false,
            leadingInput: true,
            options: customRequirement.options
                .map(
                  (v) => FormBuilderFieldOption(
                    value: v,
                  ),
                )
                .toList(),
            validators: [
              FormBuilderValidators.required(),
            ],
          ),
        );
        break;
      default:
        return FilePickerButton(
          label: 'Select file to save',
          description: description,
          width: width,
          heigth: height,
          styles: styles,
          decoration: inputDecoration,
          /* onTap: () async {
            String path = await FilePicker.getFilePath(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            onChanged("WENA:  ${path ?? 'No seleccionaste nada'}");
          }, */
        );
        break;
    }
  }
}
