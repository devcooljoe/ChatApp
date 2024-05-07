// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileModel {
  String email;
  String name;
  String? picture;
  ProfileModel({
    required this.email,
    required this.name,
    this.picture,
  });

  ProfileModel copyWith({
    String? email,
    String? name,
    String? picture,
  }) {
    return ProfileModel(
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'picture': picture,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      email: map['email'] as String,
      name: map['name'] as String,
      picture: map['picture'] != null ? map['picture'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProfileModel(email: $email, name: $name, picture: $picture)';

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.name == name && other.picture == picture;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ picture.hashCode;
}
