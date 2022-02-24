class ShoppingLists {
  List<ShoppingList>? shoppingList;

  ShoppingLists({this.shoppingList});

  ShoppingLists.fromJson(Map<String, dynamic> json) {
    if (json['shopping_list'] != null) {
      shoppingList = <ShoppingList>[];
      json['shopping_list'].forEach((v) {
        shoppingList!.add(ShoppingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shoppingList != null) {
      data['shopping_list'] = shoppingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShoppingList {
  String? name;
  int? id;
  List<Product>? products;

  ShoppingList({this.name, this.id, this.products});

  ShoppingList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? name;
  int? id;

  Product({this.name, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
