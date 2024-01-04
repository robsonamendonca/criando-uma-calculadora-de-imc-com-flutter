// ignore_for_file: file_names

class ListPurchaseModal {
        int? id;
        String? item;
        String? categoria;
        bool done =false;

  ListPurchaseModal(
    this.id,
    this.item,
    this.categoria,
    this.done,
  );

  ListPurchaseModal.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    item = json['item'];
    categoria = json['categoria'];
    done = json['done'];
  }

}
