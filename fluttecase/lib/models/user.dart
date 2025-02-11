class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final Address address;
  String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'].toString(),
      lng: json['lng'].toString(),
    );
  }
}
