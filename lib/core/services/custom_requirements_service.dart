import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRequirementsService {
  Dio dio = Dio();

  Future<Response> getCustomRequirements() async {
    //Response response =
    //await dio.get('http://**********:88/WordPress/wp-json/wp/v2/posts/');
    String jsonData =
        await rootBundle.loadString('assets/get.json'); // quitar es dummy

    Response response = Response(data: jsonData); // quitar es dummy
    return response;
  }

  Future<Response> postCustomRequirements(String data) async {
    Response response = await dio.post(
        'http://**********:88/WordPress/wp-json/wp/v2/posts/',
        data: data);

    return response;
  }
}
