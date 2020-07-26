import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantdemo/models/address.dart';
import 'package:restaurantdemo/resources/resources.dart' as resources;

class Restaurant {
  String id;
  String name;
  int type;

  RestaurantType get restaurantType =>
      type == 1 ? RestaurantType.ITALIAN : RestaurantType.CHINESE;
  double rating;
  String image;
  Address address;
  int status;

  RestaurantStatus get restaurantStatus =>
      status == 1 ? RestaurantStatus.OPEN : RestaurantStatus.CLOSE;
  int noOfFollowers;
  String distance;

  Restaurant({
    this.id,
    this.name,
    this.type,
    this.rating,
    this.image,
    this.address,
    this.status,
    this.noOfFollowers,
    this.distance,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        rating: json["rating"].toDouble(),
        image: json["image"],
        address: Address.fromJson(json["address"]),
        status: json["status"],
        noOfFollowers: json["noOfFollowers"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "type": type,
        "rating": rating,
        "image": image,
        "address": address.toJson(),
        "status": status,
        "noOfFollowers": noOfFollowers,
        "distance": distance
      };

  static String get dummyJson => json.encode(dummyData);

  static List<Restaurant> get dummyRestaurantList =>
      RestaurantListFromJson(json.decode(dummyJson));

  @override
  String toString() {
    return '''
      Restaurant(
        id: $id,
        name: $name,
        type: $type,
        rating: $rating,
        image: $image,
        address: $address,
        status: $status,
        noOfFollowers: $noOfFollowers,
        distance: $distance,
      )
    ''';
  }
}

enum RestaurantStatus { OPEN, CLOSE }

extension RestaurantStatusExtension on RestaurantStatus {
  String get status {
    if (this == RestaurantStatus.OPEN) return 'OPEN';
    if (this == RestaurantStatus.CLOSE) return 'CLOSE';
  }

  Color get statusColor {
    if (this == RestaurantStatus.OPEN) return Colors.green;
    if (this == RestaurantStatus.CLOSE) return Colors.red;
  }
}

enum RestaurantType { ITALIAN, CHINESE }

extension RestaurantTypeExtension on RestaurantType {
  List<Color> get colorList {
    if (this == RestaurantType.ITALIAN)
      return [Color(0xFFFFB289), Color(0xFFFF92A2)];
    if (this == RestaurantType.CHINESE)
      return [Color(0xFFAE74F9), Color(0xFFFC859D)];
  }

  String get name {
    if (this == RestaurantType.ITALIAN) return 'Italian';
    if (this == RestaurantType.CHINESE) return 'Chinese';
  }
}

List<Restaurant> RestaurantListFromJson(Map<String, dynamic> jsonMap) =>
    List<Restaurant>.from(jsonMap["restaurant"]
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson)));

Restaurant RestaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String RestaurantToJson(Restaurant data) => json.encode(data.toJson());

const dummyData = {
  "restaurant": [
    {
      "id": "11",
      "name": "Happy Bones",
      "type": 1,
      "rating": 4.5,
      "image": "${resources.ic_happy_bones}",
      "status": 1,
      "distance": "1.2 km",
      "noOfFollowers": 6,
      "address": {
        "id": "1",
        "line1": "394",
        "line2": "Broome St",
        "city": "New York",
        "cityCode": "NY",
        "postalCode": "10013",
        "country": "USA"
      }
    },
    {
      "id": "12",
      "name": "Uncle Boons",
      "type": 2,
      "rating": 4.3,
      "image": "${resources.ic_uncle_boons}",
      "status": 1,
      "distance": "2.5 km",
      "noOfFollowers": 2,
      "address": {
        "id": "2",
        "line1": "7",
        "line2": "Spring St",
        "city": "New York",
        "cityCode": "NY",
        "postalCode": "10012",
        "country": "USA"
      }
    },
    {
      "id": "13",
      "name": "Strawberry Bear",
      "type": 1,
      "rating": 4.2,
      "image": "${resources.ic_strawberry_bear}",
      "status": 0,
      "distance": "3.2 km",
      "noOfFollowers": 1,
      "address": {
        "id": "3",
        "line1": "127",
        "line2": "Piano St",
        "city": "New York",
        "cityCode": "NY",
        "postalCode": "10011",
        "country": "USA"
      }
    },
  ]
};
