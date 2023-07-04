import 'package:buddies_app/features/pets/data/repositories/pet_repository_impl.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/create_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


Future <void> init() async{

  // Cubits

  sl.registerFactory(
        () => PetCubit(
      deletePetUseCase: sl.call(),
      updatePetUseCase: sl.call(),
      getPetsUseCase: sl.call(),
      getPetsByIdUseCase: sl.call(),
    ),
  );

// Use Cases
  sl.registerLazySingleton(() => DeletePetUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetPetsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetPetsByIdUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePetUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreatePetUseCase(repository: sl.call()));



}


