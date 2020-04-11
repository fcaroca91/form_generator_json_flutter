import 'package:challenge_wolf/ui/screens/home_styles.dart';

import 'package:challenge_wolf/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:challenge_wolf/core/models/custom_requirement_model.dart';

class JsonCustomRequirementsComponents extends StatefulWidget {
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
  _JsonCustomRequirementsComponentsState createState() =>
      _JsonCustomRequirementsComponentsState();
}

class _JsonCustomRequirementsComponentsState
    extends State<JsonCustomRequirementsComponents> {
  GlobalKey<FormFieldState> specifyTextFieldKey;

  String helperText;

  @override
  void initState() {
    helperText = widget.customRequirement.description;
    specifyTextFieldKey = GlobalKey<FormFieldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String labelText = widget.customRequirement.question;

    final String description = widget.customRequirement.description;

    final String attribute =
        widget.customRequirement.customRequirementId.toString();

    final double width = widget.styles.sizeW(300);
    final double height = widget.styles.sizeW(85);

    final InputDecoration inputDecoration = InputDecoration(
      labelText: labelText,
      labelStyle: widget.styles.textFormField,
      //helperText: helperText,
      //helperText: description,
      /* errorStyle: TextStyle(
        color: Colors.red,
        fontSize: styles.sizeH(10.0),
      ), */
      contentPadding: EdgeInsets.fromLTRB(
        widget.styles.sizeW(20),
        widget.styles.sizeH(15),
        widget.styles.sizeW(20),
        widget.styles.sizeH(0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          widget.styles.sizeW(5),
        ),
      ),
    );

    final EdgeInsets margin = EdgeInsets.only(
      top: widget.styles.sizeH(20),
      bottom: widget.styles.sizeH(0),
    );

    switch (widget.customRequirement.fieldType) {
      case "Freetext":
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: widget.styles.sizeH(7),
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ),
            Container(
              width: width,
              height: height,
              margin: margin,
              child: FormBuilderTextField(
                key: specifyTextFieldKey,
                attribute: attribute,
                decoration: inputDecoration,
                onChanged: (v) {
                  /* if (specifyTextFieldKey.currentState.validate()) {
                    setState(() {
                      helperText = description;
                    });
                  } else
                    setState(() {
                      helperText = "";
                    }); */
                },
                validators: [
                  FormBuilderValidators.required(),
                ],
                keyboardType: TextInputType.text,
              ),
            ),
            /* Positioned(
              top: widget.styles.sizeH(80),
              child: UrlLaunchHtml(
                description: helperText,
                styles: widget.styles,
              ),
            ), */
          ],
        );
        break;
      case "Integer":
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: widget.styles.sizeH(7),
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ),
            Container(
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
            ),
            /* Positioned(
              top: widget.styles.sizeH(68),
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ), */
          ],
        );
        break;
      case "Dropdown":
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: widget.styles.sizeH(7),
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ),
            Container(
              width: width,
              height: height,
              margin: margin,
              child: FormBuilderDropdown(
                attribute: attribute,
                initialValue: widget.customRequirement.value,
                decoration: inputDecoration,
                hint: Text('Select Value'),
                validators: [
                  FormBuilderValidators.required(),
                ],
                items: widget.customRequirement.options
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text('$value'),
                        ))
                    .toList(),
              ),
            ),
            /* Positioned(
              top: widget.styles.sizeH(68),
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ), */
          ],
        );
        break;
      case "Checkbox":
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: widget.styles.sizeH(0), //24
              child: UrlLaunchHtml(
                description: description,
                styles: widget.styles,
              ),
            ),
            Container(
              width: width,
              margin: EdgeInsets.only(
                top: widget.styles.sizeH(20),
                bottom: widget.styles.sizeH(25),
              ),
              child: FormBuilderCheckboxList(
                attribute: 'checkBox',
                initialValue: widget
                    .customRequirement.value, //pueden venir todos seleccionados
                decoration: inputDecoration,
                //initialValue: false,
                leadingInput: true,
                options: widget.customRequirement.options
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
            ),
          ],
        );
        break;
      default:
        return Container(
          margin: EdgeInsets.only(
            top: widget.styles.sizeH(20),
            bottom: widget.styles.sizeH(25),
          ),
          child: FilePickerButton(
            label: widget.customRequirement.question,
            description: description,
            width: width,
            styles: widget.styles,
            customRequirementId: attribute,
            value: widget.customRequirement.value,
          ),
        );
        break;
    }
  }
}
