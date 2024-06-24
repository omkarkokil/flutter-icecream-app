class Icecream {
  Icecream({
    required this.flavor,
    this.description,
    this.toppings,
    this.price,
    this.image,
    required this.ingredients,
  });

  String flavor;
  String? description;
  List<String>? toppings;
  double? price;
  String? image;
  List<Ingredient> ingredients;

  // Factory constructor to create an Icecream object from JSON
  factory Icecream.fromJson(Map<String, dynamic> json) => Icecream(
        flavor: json["flavor"],
        description: json["description"],
        toppings: json["toppings"] != null
            ? List<String>.from(json["toppings"])
            : null,
        price: json["price"]?.toDouble(),
        image: json["image"],
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  // Method to convert an Icecream object to JSON
  Map<String, dynamic> toJson() => {
        "flavor": flavor,
        "description": description,
        "toppings": toppings != null ? List<dynamic>.from(toppings!) : null,
        "price": price,
        "image": image,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };
}

class Ingredient {
  Ingredient({
    this.name,
    this.quantity,
  });

  String? name;
  String? quantity;

  // Factory constructor to create an Ingredient object from JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        name: json["name"],
        quantity: json["quantity"],
      );

  // Method to convert an Ingredient object to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };
}
