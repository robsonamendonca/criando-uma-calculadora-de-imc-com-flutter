// ignore_for_file: non_constant_identifier_names

import 'package:tarefasapp/repositories/back4app_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASE_URL");
    debugPrint('_dio.options.baseUrl: ${_dio.options.baseUrl}');
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
