class ProductListModel {
  List<Product>? products;

  ProductListModel({this.products});

  // Factory constructor to create a ProductList from JSON (a list of products)
  factory ProductListModel.fromJson(List<dynamic> json) {
    return ProductListModel(
      products: json.map((product) => Product.fromJson(product)).toList(),
    );
  }

  // Method to convert a ProductList to JSON
  List<Map<String, dynamic>> toJson() {
    return products?.map((product) => product.toJson()).toList() ?? [];
  }
}

class Product {
  int? id;
  String? title;
  String? price;
  String? category;
  String? description;
  String? image;

  Product(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image});

  // Factory constructor to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toString(),
      category: json['category'],
      description: json['description'],
      image: json['image'],
    );
  }

  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
    };
  }
}
