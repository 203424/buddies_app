import 'dart:io';

class PetEntity {
  final int? id;
  final int? owner_id;
  final String? name;
  final String? birthday;
  final String? type;
  final String? breed;
  final String? gender;
  final String? size;
  final String? description;

  PetEntity({
    this.owner_id,
    this.name,
    this.birthday,
    this.type,
    this.breed,
    this.gender,
    this.size,
    this.id,
    this.description,
});


}
