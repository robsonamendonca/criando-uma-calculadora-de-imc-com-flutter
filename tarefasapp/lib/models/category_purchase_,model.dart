// ignore_for_file: file_names, non_constant_identifier_names
class CategoryPurchaseModal {
  List<CategoryPurchase> categoryPurchase = [];

  CategoryPurchaseModal({required this.categoryPurchase});

  CategoryPurchaseModal.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      categoryPurchase = <CategoryPurchase>[];
      json['results'].forEach((v) {
        categoryPurchase.add(CategoryPurchase.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = categoryPurchase.map((v) => v.toJson()).toList();
    return data;
  }
}

class CategoryPurchase {
  String? objectId;
  String? name;
  String? urlPhoto;
  String? createdAt;
  String? updatedAt;

  CategoryPurchase(
      {this.objectId,
      this.name,
      this.urlPhoto,
      this.createdAt,
      this.updatedAt});

  CategoryPurchase.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    urlPhoto = json['url_photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['name'] = name;
    data['url_photo'] = urlPhoto;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
