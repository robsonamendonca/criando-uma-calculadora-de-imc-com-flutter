import 'dart:convert';

import 'package:cepapp/model/ceps_viacep_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CepsViaCepRepository {
  Future<CepsViaCepModel> obterCep(String cep) async {
    var dio = Dio();
    var response = await dio.request(
      'https://viacep.com.br/ws/$cep/json/',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return CepsViaCepModel.fromJson(response.data);
  }
}
