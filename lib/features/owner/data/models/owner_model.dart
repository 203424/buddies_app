import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';

class OwnerModel extends OwnerEntity {
  OwnerModel({
    int? id,
    String? name,
    String? email,
    String? password,
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
  );


  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  factory OwnerModel.fromEntity(OwnerEntity owner) {
    return OwnerModel(
      id: owner.id,
      name: owner.name,
      email: owner.email,
      password: owner.password,
    );
  }
  static Map<String, dynamic> fromEntityToJsonCreate(OwnerEntity owner) {
    return {
      'id': owner.id,
      'name': owner.name,
      'email': owner.email,
      'password': owner.password,
    };
  }
  @override
  String toString() {
    return 'PetModel(id: $id, name: $name, email: $password, password: $password,)';
  }
}
