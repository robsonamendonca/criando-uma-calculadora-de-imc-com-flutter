import 'package:flutter/cupertino.dart';
import 'package:tarefasapp/controllers/listpurchase_controller.dart';
import 'package:tarefasapp/models/category_purchase_,model.dart';

class CategoryPurchaseService with ChangeNotifier{
  final List<CategoryPurchase> _items = ListPurchaseController().categorysList.cast<CategoryPurchase>();

  List<CategoryPurchase> get all {
    debugPrint(_items.length.toString());
    return _items;
  }

  int get count {
    return _items.length;
  }

  CategoryPurchase byIndex(int i){
    return _items[i];
  }

  void save(CategoryPurchase category){
    
  }

}