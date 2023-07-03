import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';
import 'package:buddies_app/features/pets/data/data_sources/pet_remote.dart';


class PetRepositoryImpl implements PetRepository {
  final PetRemoteDataSource petRemoteDataSource;

  PetRepositoryImpl({required this.petRemoteDataSource});

  @override
  Future<void> createPet(List<PetEntity> pet) async {
    return await  petRemoteDataSource.createPet(pet);

  }

  @override
  Future<void> deletePet(PetEntity pet) async {
    return await petRemoteDataSource.deletePet(pet);

  }

  @override
  Future<List<PetEntity>> getPets() async{
    return await petRemoteDataSource.getPets();
  }

  @override
  Future<List<PetEntity>> getPetsById() async {
    return await petRemoteDataSource.getPetsById();

  }

  @override
  Future<void> updatePet(PetEntity pet) async {
    return await  petRemoteDataSource.updatePet(pet);
  }


}