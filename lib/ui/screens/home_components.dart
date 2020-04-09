import 'package:challenge_wolf/core/models/custom_requirement_model.dart';
import 'package:flutter/material.dart';
import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/screens/json_custom_requirements_components.dart';

mixin HomeComponents {
  HomeStyles styles;

  void initHomeComponents(BuildContext context) {
    styles = HomeStyles(context);
  }

  List<Widget> homeComponents(List<CustomRequirement> data) {
    return data
        .map(
          (v) => JsonCustomRequirementsComponents(
            onChanged: (v) => print(v),
            customRequirement: v,
            styles: styles,
          ),
        )
        .toList();
  }
}
