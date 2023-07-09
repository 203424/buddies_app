

import 'package:buddies_app/features/pets/data/repositories/pet_repository_impl.dart';

import 'features/pets/data/data_sources/pet_remote.dart';
import 'features/pets/domain/usecases/pet_usecases/create_pet_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/get_pets_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';

class UseCaseConfig{
  PetRepositoryImpl? petRepositoryImpl;
  PetRemoteDataSourceImpl? petRemoteDataSourceImpl;
  CreatePetUseCase? createPetUseCase;
  DeletePetUseCase? deletePetUseCase;
  GetPetsByIdUseCase? getPetsByIdUseCase;
  GetPetsUseCase? getPetsUseCase;
  UpdatePetUseCase? updatePetUseCase;

  UseCaseConfig() {
    petRemoteDataSourceImpl = PetRemoteDataSourceImpl();
    petRepositoryImpl = PetRepositoryImpl(petRemoteDataSource: petRemoteDataSourceImpl!);
    createPetUseCase = CreatePetUseCase( petRepositoryImpl!);
    deletePetUseCase = DeletePetUseCase( petRepositoryImpl!);
    getPetsByIdUseCase = GetPetsByIdUseCase( petRepositoryImpl!);
    getPetsUseCase = GetPetsUseCase( petRepositoryImpl!); // Initialize getPetsUseCase
    updatePetUseCase = UpdatePetUseCase( petRepositoryImpl!);
  }
}