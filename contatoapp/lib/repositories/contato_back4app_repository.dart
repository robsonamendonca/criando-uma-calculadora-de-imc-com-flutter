// ignore_for_file: unused_field

import 'dart:convert';

import 'package:contatoapp/model/contatos_back4app_model.dart';
import 'package:contatoapp/repositories/back4app_custom_dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ContatosBack4AppRepository {
  final _customDio = Back4AppCustomDio();
  ContatosBack4AppRepository();

  Future<ContatosBack4AppModel> obterContatos() async {
    var url = "/contatos";
    var response = await _customDio.dio.get(url);
    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return ContatosBack4AppModel.fromJson(response.data);
  }

  Future<ContatosBack4AppModel> obterConttatosPorTelefone(
      String telefone) async {
    var urlApiWhere = "/contatos?where={\"telefone\":\"$telefone\"}";
    var response = await _customDio.dio.get(urlApiWhere);

    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return ContatosBack4AppModel.fromJson(response.data);
  }

  Future<bool> inserirContato(ContatoModel contato) async {
    ContatosBack4AppModel buscaContato;
    try {
      buscaContato =
          await obterConttatosPorTelefone(contato.telefone.toString());
      debugPrint(buscaContato.contatos?.isNotEmpty.toString());
      if (buscaContato.contatos!.isNotEmpty) {
        return true;
      }
      await _customDio.dio.post("/contatos", data: contato.toJsonBody());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> alterarContato(ContatoModel cep) async {
    String objectId = cep.objectId.toString();
    try {
      await _customDio.dio.put("/contatos/$objectId", data: cep.toJsonBody());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      debugPrint(cep.toJsonBody().toString());
      return false;
    }
  }

  Future<bool> deletarContato(String id) async {
    try {
      await _customDio.dio.delete("/contatos/$id");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<int> obterQtdeContatos() async {
    var url = "/contatos";
    var response = await _customDio.dio.get(url);
    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
    return (response.data.length);
  }
  Future<int> obterQtdeAniverContatos() async {
     var list = ContatosBack4AppModel([]);
     final today = DateTime.now();
     list = await obterContatos();
    NumberFormat formatter = NumberFormat("00");
      var aniversariantesDoDia = list.contatos!.where((item) {
        final dataNascimento = DateTime.parse(
          '${today.year}-${formatter.format(item.mesNascimento)}-${formatter.format(item.diaNascimento)}',
        );
        return dataNascimento.month == today.month &&
            dataNascimento.day == today.day;
      }).toList();
    return aniversariantesDoDia.length;
  }  
}
