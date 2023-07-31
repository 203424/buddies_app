import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';
import 'package:buddies_app/features/pets/data/data_sources/pet_remote.dart';


class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource petRemoteDataSource;

  PetRepositoryImpl({required this.petRemoteDataSource});

  @override
  Future<List<PetEntity>> createPet(List<PetEntity> pets) async {
    return await petRemoteDataSource.createPet(pets);
  }

  @override
  Future<void> deletePet(int petid) async {
    return await petRemoteDataSource.deletePet(petid);

  }

  @override
  Future<List<PetEntity>> getPets() async{
    return await petRemoteDataSource.getPets();
  }

  @override
  Future<List<PetEntity>> getPetsById(List<int> petsId) async {
    return await petRemoteDataSource.getPetsById(petsId);

  }

  @override
  Future<List<PetEntity>> updatePet(List<int> petIds, List<PetEntity> pets) async {
    return await petRemoteDataSource.updatePet(pets, petIds);
  }

  @override
  Future<List<PetEntity>> getPetsByUserId(int id) async {
    return await petRemoteDataSource.getPetsByUserId(id);

  }


}