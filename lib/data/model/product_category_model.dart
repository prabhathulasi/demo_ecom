class CategoryModel {
  List<String>? categories;

  CategoryModel({this.categories});

  // Factory constructor to create an instance from a List (directly from JSON array)
  factory CategoryModel.fromJson(List<dynamic> json) {
    return CategoryModel(
      categories: json.cast<String>(),
    );
  }

  // Method to convert the List<String> to JSON array
  List<dynamic> toJson() {
    return categories ?? [];
  }
}
