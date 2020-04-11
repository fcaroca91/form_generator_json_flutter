// To parse this JSON data, do
//
//     final customRequirement = customRequirementFromJson(jsonString);

import 'dart:convert';

List<CustomRequirement> customRequirementFromJson(String str) =>
    List<CustomRequirement>.from(
        json.decode(str).map((x) => CustomRequirement.fromJson(x)));

String customRequirementToJson(List<CustomRequirement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomRequirement {
  int customRequirementId;
  String question;
  String fieldType;
  String units;
  List<String> options;
  String requiredLevel;
  String description;
  dynamic value;

  CustomRequirement({
    this.customRequirementId,
    this.question,
    this.fieldType,
    this.units,
    this.options,
    this.requiredLevel,
    this.description,
    this.value,
  });

  factory CustomRequirement.fromJson(Map<String, dynamic> json) =>
      CustomRequirement(
        customRequirementId: json["custom_requirement_id"],
        question: json["question"],
        fieldType: json["field_type"],
        units: json["units"],
        options: json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
        requiredLevel: json["required_level"],
        description: json["description"] == null ? null : json["description"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "custom_requirement_id": customRequirementId,
        "question": question,
        "field_type": fieldType,
        "units": units,
        "options":
            options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "required_level": requiredLevel,
        "description": description == null ? null : description,
        "value": value == null ? null : value,
      };
}
