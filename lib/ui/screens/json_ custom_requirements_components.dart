import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';

import 'package:challenge_wolf/core/models/custom_requirement_model.dart';

class JsonCustomRequirementsComponents extends StatefulWidget {
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final String form;
  
  final Widget buttonSave;
  final Function actionSave;
  final ValueChanged<dynamic> onChanged;

  const JsonCustomRequirementsComponents({
    @required this.form,
    @required this.onChanged,
    
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.buttonSave,
    this.actionSave,
  });

  @override
  _JsonCustomRequirementsComponentsState createState() =>
      _JsonCustomRequirementsComponentsState(json.decode(form));
}

class _JsonCustomRequirementsComponentsState
    extends State<JsonCustomRequirementsComponents> {
  final dynamic formGeneral;

  final CustomRequirement _customRequiremen = CustomRequirement();

  int radioValue;

  // validators

  String isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }

  String validateEmail(item, String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  bool labelHidden(item) {
    if (item.containsKey('hiddenLabel')) {
      if (item['hiddenLabel'] is bool) {
        return !item['hiddenLabel'];
      }
    } else {
      return true;
    }
    return false;
  }

  // Return widgets

  List<Widget> jsonToForm() {
    List<Widget> listWidget = List<Widget>();
    /* if (formGeneral['title'] != null) {
      listWidget.add(Text(
        formGeneral['title'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ));
    }
    if (formGeneral['description'] != null) {
      listWidget.add(Text(
        formGeneral['description'],
        style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      ));
    } */

    for (var count = 0; count < formGeneral['fields'].length; count++) {
      Map item = formGeneral['fields'][count];

      if (item['type'] == "Input" ||
          item['type'] == "Password" ||
          item['type'] == "Email" ||
          item['type'] == "TextArea" ||
          item['type'] == "TextInput") {
        Widget label = SizedBox.shrink();
        if (labelHidden(item)) {
          label = Container(
            child: Text(
              item['label'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          );
        }

        listWidget.add(Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label,
              TextFormField(
                controller: null,
                initialValue: formGeneral['fields'][count]['value'] ?? null,
                decoration: item['decoration'] ??
                    widget.decorations[item['key']] ??
                    InputDecoration(
                      hintText: item['placeholder'] ?? "",
                      helperText: item['helpText'] ?? "",
                    ),
                maxLines: item['type'] == "TextArea" ? 10 : 1,
                onChanged: (String value) {
                  formGeneral['fields'][count]['value'] = value;
                  _handleChanged();
                },
                obscureText: item['type'] == "Password" ? true : false,
                validator: (value) {
                  if (widget.validations.containsKey(item['key'])) {
                    return widget.validations[item['key']](item, value);
                  }
                  if (item.containsKey('validator')) {
                    if (item['validator'] != null) {
                      if (item['validator'] is Function) {
                        return item['validator'](item, value);
                      }
                    }
                  }
                  if (item['type'] == "Email") {
                    return validateEmail(item, value);
                  }

                  if (item.containsKey('required')) {
                    if (item['required'] == true ||
                        item['required'] == 'True' ||
                        item['required'] == 'true') {
                      return isRequired(item, value);
                    }
                  }

                  return null;
                },
              ),
            ],
          ),
        ));
      }

      if (item['type'] == "RadioButton") {
        List<Widget> radios = [];

        if (labelHidden(item)) {
          radios.add(Text(item['label'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
        }
        radioValue = item['value'];
        for (var i = 0; i < item['items'].length; i++) {
          radios.add(
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        formGeneral['fields'][count]['items'][i]['label'])),
                Radio<int>(
                    value: formGeneral['fields'][count]['items'][i]['value'],
                    groupValue: radioValue,
                    onChanged: (int value) {
                      this.setState(() {
                        radioValue = value;
                        formGeneral['fields'][count]['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }

        listWidget.add(
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: radios,
            ),
          ),
        );
      }

      if (item['type'] == "Switch") {
        if (item['value'] == null) {
          formGeneral['fields'][count]['value'] = false;
        }
        listWidget.add(
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Row(children: <Widget>[
              Expanded(child: Text(item['label'])),
              Switch(
                value: item['value'] ?? false,
                onChanged: (bool value) {
                  this.setState(() {
                    formGeneral['fields'][count]['value'] = value;
                    _handleChanged();
                  });
                },
              ),
            ]),
          ),
        );
      }

      if (item['type'] == "Checkbox") {
        List<Widget> checkboxes = [];
        if (labelHidden(item)) {
          checkboxes.add(Text(item['label'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)));
        }
        for (var i = 0; i < item['items'].length; i++) {
          checkboxes.add(
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        formGeneral['fields'][count]['items'][i]['label'])),
                Checkbox(
                  value: formGeneral['fields'][count]['items'][i]['value'],
                  onChanged: (bool value) {
                    this.setState(
                      () {
                        formGeneral['fields'][count]['items'][i]['value'] =
                            value;
                        _handleChanged();
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }

        listWidget.add(
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: checkboxes,
            ),
          ),
        );
      }

      if (item['type'] == "Select") {
        Widget label = SizedBox.shrink();
        if (labelHidden(item)) {
          label = Text(item['label'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0));
        }

        listWidget.add(Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label,
              DropdownButton<String>(
                hint: Text("Select a user"),
                value: formGeneral['fields'][count]['value'],
                onChanged: (String Value) {
                  setState(() {
                    formGeneral['fields'][count]['value'] = Value;
                    _handleChanged();
                  });
                },
                items:
                    item['items'].map<DropdownMenuItem<String>>((dynamic data) {
                  return DropdownMenuItem<String>(
                    value: data['value'],
                    child: Text(
                      data['label'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
      }
    }

    if (widget.buttonSave != null) {
      listWidget.add(Container(
        margin: EdgeInsets.only(top: 10.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState.validate()) {
              widget.actionSave(formGeneral);
            }
          },
          child: widget.buttonSave,
        ),
      ));
    }
    return listWidget;
  }

  _JsonCustomRequirementsComponentsState(this.formGeneral);

  void _handleChanged() {
    widget.onChanged(formGeneral);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: formGeneral['autoValidated'] ?? false,
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(8.0 ?? 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: jsonToForm(),
        ),
      ),
    );
  }
}
