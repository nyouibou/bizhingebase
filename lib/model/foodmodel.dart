// To parse this JSON data, do
//
//     final sampleFoodApiResp = sampleFoodApiRespFromJson(jsonString);

import 'dart:convert';

MealModel sampleFoodApiRespFromJson(String str) =>
    MealModel.fromJson(json.decode(str));

String sampleFoodApiRespToJson(MealModel data) => json.encode(data.toJson());

class MealModel {
  List<Meal>? meals;

  MealModel({
    this.meals,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        meals: json["meals"] == null
            ? []
            : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": meals == null
            ? []
            : List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
