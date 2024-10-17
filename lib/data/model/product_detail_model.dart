class ProductDetailModel {
  int? id;
  String? title;
  String? price;
  String? category;
  String? description;
  String? image;

  ProductDetailModel(
      {this.id,
      this.title,
      this.price,
      this.category,
      this.description,
      this.image});

  // Factory constructor to create a Product instance from JSON
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
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
