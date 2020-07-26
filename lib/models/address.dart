import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;

  final String line1;

  final String line2;

  final String city;

  final String cityCode;

  final String postalCode;

  final String country;

  const Address({
    this.id,
    this.line1,
    this.line2,
    this.city,
    this.cityCode,
    this.postalCode,
    this.country,
  });

  @override
  List<Object> get props =>
      [id, line1, line2, city, cityCode, postalCode, country];

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        line1: json['line1'],
        line2: json['line2'],
        city: json['city'],
        cityCode: json['cityCode'],
        postalCode: json['postalCode'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'line1': line1,
        'line2': line2,
        'city': city,
        'cityCode': cityCode,
        'postalCode': postalCode,
        'country': country,
      };

  String get wholeAddress {
    return '${line1 ?? ''} ${line2 ?? ''}, ${city ?? ''}, ${cityCode ?? ''} ${postalCode ?? ''}, ${country ?? ''}';
  }
}
