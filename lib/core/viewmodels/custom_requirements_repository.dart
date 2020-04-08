import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:challenge_wolf/locator.dart';

import 'package:challenge_wolf/core/services/custom_requirements_service.dart';
import 'package:challenge_wolf/core/models/custom_requirement_model.dart';

class CustomRequirementsRepository extends ChangeNotifier {
  CustomRequirementsService api = locator<CustomRequirementsService>();

  Future<List<CustomRequirement>> fetchCustomRequirements() async {
    Response response = await api.getCustomRequirements();
    List responseJson = json.decode(response.data);
    return responseJson.map((m) => CustomRequirement.fromJson(m)).toList();
  }

  Future saveCustomRequirements(List<CustomRequirement> data) async {
    Response response =
        await api.postCustomRequirements(customRequirementToJson(data));

    return response;
  }
}
