import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

class PetModel extends PetEntity {
  PetModel({
    int? id,
    String? name,
    String? birthday,
    String? type,
    String? breed,
    String? gender,
    String? size,
    String? description,
    int? owner_id,

  }) : super(
            id: id,
            name: name,
            birthday: birthday,
            type: type,
            breed: breed,
            gender: gender,
            size: size,
            description: description,
            owner_id: owner_id,
  );


  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      birthday: json['birthday'],
      type: json['type'],
      breed: json['breed'],
      gender: json['gender'],
      size: json['size'],
      description: json['description'],
      owner_id: json['owner_id'],

    );
  }

  factory PetModel.fromEntity(PetEntity pet) {
    return PetModel(
        id: pet.id,
        name: pet.name,
        birthday: pet.birthday,
        type: pet.type,
        breed: pet.breed,
        gender: pet.gender,
        size: pet.size,
        description: pet.description,
        owner_id: pet.owner_id,

    );
  }
    static Map<String, dynamic> fromEntityToJsonCreate(PetEntity pet) {
      return {
        'id': pet.id,
        'name': pet.name,
        'birthday': pet.birthday,
        'type': pet.type,
        'breed': pet.breed,
        'gender': pet.gender,
        'size': pet.size,
        'description': pet.description,
        'owner_id': pet.owner_id,

      };
    }
  @override
  String toString() {
    return 'PetModel(id: $id, name: $name, birthday: $birthday, type: $type, breed: $breed, gender: $gender, size: $size, description: $description, owner_id: $owner_id)';
  }
}

