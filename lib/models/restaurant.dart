import 'dart:convert';
/*
class Restaurants {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menus menus;
  late bool isFavorite;

  Restaurants(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus,
      required this.isFavorite});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toDouble();
    menus = (json['menus'] != null ? Menus.fromJson(json['menus']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['rating'] = rating;
    data['menus'] = menus.toJson();
    return data;
  }
}

class Menus {
  late List<Foods> foods;
  late List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foods'] = foods.map((v) => v.toJson()).toList();
    data['drinks'] = drinks.map((v) => v.toJson()).toList();
    return data;
  }
}

class Foods {
  late String name;

  Foods({required this.name});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Drinks {
  late String name;

  Drinks({required this.name});

  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

List<Restaurants> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurants.fromJson(json)).toList();
}
*/
// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

Restaurants restaurantFromJson(String str) =>
    Restaurants.fromJson(json.decode(str));

String restaurantToJson(Restaurants data) => json.encode(data.toJson());

class Restaurants {
  Restaurants(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants,
      required this.isFavorite});

  final bool error;
  final String message;
  final int count;
  final List<RestaurantElement> restaurants;
  final bool isFavorite;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantElement>.from(
            json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
        isFavorite: false,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantElement {
  RestaurantElement({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory RestaurantElement.fromJson(Map<String, dynamic> json) =>
      RestaurantElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
