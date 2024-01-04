import 'package:get/get.dart';
import 'package:tarefasapp/models/category_purchase_,model.dart';
import 'package:tarefasapp/models/listpurchase_model.dart';
import 'package:tarefasapp/repositories/listpurchase_repository.dart';

class ListPurchaseController extends GetxController{
  ListPurchaseRepository repository = ListPurchaseRepository();
  
  List<CategoryPurchase> get categorys => repository.getCategorys().categoryPurchase.toList();

  List<ListPurchaseModal> get categorysList => repository.getListCategorys().toList();

}