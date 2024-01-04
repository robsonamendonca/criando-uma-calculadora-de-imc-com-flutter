import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarefasapp/models/category_purchase_,model.dart';
import 'package:tarefasapp/models/listpurchase_model.dart';
import 'package:tarefasapp/repositories/back4app_custom_dio.dart';

class ListPurchaseRepository extends GetConnect {
  final _customDio = Back4AppCustomDio();
  String urlBase =
      "https://raw.githubusercontent.com/robsonamendonca/qcomprar/main/src/app/";
  Future<List<ListPurchaseModal>> getListPurchase() async {
    List<ListPurchaseModal> listPurchase = [];

    var url = "$urlBase/data.json";

    final response = await get(url);

    final listPurchases = response.body;

    for (Map purche in listPurchases) {
      ListPurchaseModal item = ListPurchaseModal.fromJson(purche);
      listPurchase.add(item);
    }

    return listPurchase;
  }

  Future<CategoryPurchaseModal> _getListPurchaseCategory() async {
    var url = "/category_purchase";
    var response = await _customDio.dio.get(url);
    if (response.statusCode == 200) {
      debugPrint('_getListPurchaseCategory ok');
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusCode.toString());
    }
    return CategoryPurchaseModal.fromJson(response.data);
  }

  List<ListPurchaseModal> getListCategorys() {
    _getListPurchaseCategory().then((value) {
      return value.categoryPurchase;
    });
    return [];
  }

    CategoryPurchaseModal getCategorys() {
    _getListPurchaseCategory().then((value) {
      return value;
    });
    return CategoryPurchaseModal(categoryPurchase: []);
  }


}
