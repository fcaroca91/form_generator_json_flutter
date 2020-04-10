import 'package:challenge_wolf/ui/screens/home_styles.dart';

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

    final double width = styles.sizeW(300);
    final double height = styles.sizeW(70);

    final InputDecoration inputDecoration = InputDecoration(
      labelText: labelText,
      labelStyle: styles.textFormField,
      helperText: description,
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: styles.sizeH(10.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(
        styles.sizeW(20),
        styles.sizeH(15),
        styles.sizeW(20),
        styles.sizeH(15),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          styles.sizeW(5),
        ),
      ),
    );

    final EdgeInsets margin = EdgeInsets.only(bottom: styles.sizeH(15),);

    switch (customRequirement.fieldType) {
      case "Freetext":
        return Container(
          width: width,
          height: height,
          margin: margin,
          child: FormBuilderTextField(
            attribute: "textInput",
            decoration: inputDecoration,
            onChanged: (v) => onChanged(v),
            validators: [
              FormBuilderValidators.requiredTrue(
                errorText: "Cant empty TextInput",
              ),
              FormBuilderValidators.max(70),
            ],
            keyboardType: TextInputType.text,
          ),
        );
        break;
      case "Integer":
        return Container(
          width: width,
          height: height,
          margin: margin,
          child: FormBuilderTextField(
            attribute: "integerInput",
            decoration: inputDecoration,
            onChanged: (v) => onChanged(v),
            valueTransformer: (text) => num.tryParse(text),
            validators: [
              FormBuilderValidators.requiredTrue(
                errorText: "Cant empty IntergetInput",
              ),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.max(10),
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
            attribute: "dropDown",
            decoration: inputDecoration,
            hint: Text('Select Value'),
            validators: [
              FormBuilderValidators.requiredTrue(
                errorText: "Select any options DropDown",
              ),
            ],
            onChanged: (v) => onChanged(v),
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
        return FormBuilderCheckbox(
          attribute: 'checkBox',
          decoration: inputDecoration,
          initialValue: false,
          onChanged: (v) => onChanged(v),
          leadingInput: true,
          label: RichText(
            text: TextSpan(
              children: customRequirement.options
                  .map(
                    (v) => TextSpan(
                      text: v,
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("launch url");
                        },
                    ),
                  )
                  .toList(),
            ),
          ),
          validators: [
            FormBuilderValidators.requiredTrue(
              errorText: "You must accept terms and conditions to continue",
            ),
          ],
        );
        break;
      default:
        return FilePickerButton(
          label: labelText,
          description: description,
          width: width,
          heigth: height,
          styles: styles,
          onPressed: () async {
            String path = await FilePicker.getFilePath(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            onChanged("WENA:  " + path ?? "");
          },
        );
        break;
    }
  }
}
