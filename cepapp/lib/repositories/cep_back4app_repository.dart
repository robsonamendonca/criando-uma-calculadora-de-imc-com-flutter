// ignore_for_file: unused_field

import 'dart:convert';

import 'package:cepapp/model/ceps_back4app_model.dart';
import 'package:cepapp/repositories/back4app_custom_dio.dart';
import 'package:flutter/material.dart';

class CepsBack4AppRepository {
  final _customDio = Back4AppCustomDio();
  CepsBack4AppRepository();

  Future<CepsBack4AppModel> obterCeps() async {
    var url = "/Ceps";
    var response = await _customDio.dio.get(url);
    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return CepsBack4AppModel.fromJson(response.data);
  }

  Future<CepsBack4AppModel> obterCepsPorCEP(String cep) async {
    var urlApiWhere = "/Ceps?where={\"cep\":\"$cep\"}";
    var response = await _customDio.dio.get(urlApiWhere);

    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return CepsBack4AppModel.fromJson(response.data);
  }

  Future<bool> inserirCep(CepBack4AppModel cep) async {
    CepsBack4AppModel buscaCEP;
    try {
      buscaCEP = await obterCepsPorCEP(cep.cep.toString());
      debugPrint(buscaCEP.ceps.isNotEmpty.toString());
      if (buscaCEP.ceps.isNotEmpty) {
        return true;
      }
      await _customDio.dio.post("/Ceps", data: cep.toJsonBody());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> alterarCep(CepBack4AppModel cep) async {
    String objectId = cep.objectId.toString();
    try {
      await _customDio.dio.put("/Ceps/$objectId", data: cep.toJsonBody());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(cep.toJsonBody().toString());
      return false;
    }
  }

  Future<bool> deletarCep(String id) async {
    try {
      await _customDio.dio.delete("/Ceps/$id");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
