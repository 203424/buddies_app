

import 'package:buddies_app/features/pets/data/repositories/pet_repository_impl.dart';
import 'package:buddies_app/features/request/domain/usecases/request_usecases/create_request_usecase.dart';
import 'package:buddies_app/features/request/domain/usecases/request_usecases/delete_request_usecase.dart';
import 'package:buddies_app/features/request/domain/usecases/request_usecases/get_by_user_id.dart';
import 'package:buddies_app/features/request/domain/usecases/request_usecases/get_in_progress_usecase.dart';

import 'features/pets/data/data_sources/pet_remote.dart';
import 'features/pets/domain/usecases/pet_usecases/create_pet_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/get_pets_usecase.dart';
import 'features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';

import 'features/request/data/data_sources/request_remote.dart';
import 'features/request/data/repositories/request_repository_impl.dart';
import 'features/request/domain/usecases/request_usecases/get_by_caretaker_id_usecase.dart';
import 'features/request/domain/usecases/request_usecases/get_all_requests_usecase.dart';
import 'features/request/domain/usecases/request_usecases/get_by_id_usecase.dart';
import 'features/request/domain/usecases/request_usecases/get_by_status_usecase.dart';
import 'features/request/domain/usecases/request_usecases/get_history_usecase.dart';
import 'features/request/domain/usecases/request_usecases/update_request_usecase.dart';


class UseCaseConfig{
  //Pet
  PetRepositoryImpl? petRepositoryImpl;
  PetRemoteDataSourceImpl? petRemoteDataSourceImpl;
  CreatePetUseCase? createPetUseCase;
  DeletePetUseCase? deletePetUseCase;
  GetPetsByIdUseCase? getPetsByIdUseCase;
  GetPetsUseCase? getPetsUseCase;
  UpdatePetUseCase? updatePetUseCase;
  //Request
  RequestRepositoryImpl? requestRepositoryImpl;
  RequestRemoteDataSourceImpl? requestRemoteDataSourceImpl;

  CreateRequestUseCase? createRequestUseCase;
  UpdateRequestUseCase? updateRequestUseCase;
  DeleteRequestUseCase? deleteRequestUseCase;
  GetByIdUseCase? getByIdUseCase;
  GetByUserIdUseCase? getByUserIdUseCase;
  GetAllRequestUseCase? getAllRequestUseCase;
  GetByStatusUseCase? getByStatusUseCase;
  GetInProgressUseCase? getInProgressUseCase;
  GetHistoryUseCase? getHistoryUseCase;
  GetByCaretakerIdUseCase? getByCaretakerIdUseCase;

  //Owner

  UseCaseConfig() {
    //Pet
    petRemoteDataSourceImpl = PetRemoteDataSourceImpl();
    petRepositoryImpl = PetRepositoryImpl(petRemoteDataSource: petRemoteDataSourceImpl!);
    createPetUseCase = CreatePetUseCase( petRepositoryImpl!);
    deletePetUseCase = DeletePetUseCase( petRepositoryImpl!);
    getPetsByIdUseCase = GetPetsByIdUseCase( petRepositoryImpl!);
    getPetsUseCase = GetPetsUseCase( petRepositoryImpl!); // Initialize getPetsUseCase
    updatePetUseCase = UpdatePetUseCase( petRepositoryImpl!);
    //Request
    requestRemoteDataSourceImpl = RequestRemoteDataSourceImpl();
    requestRepositoryImpl = RequestRepositoryImpl(requestRemoteDataSource: requestRemoteDataSourceImpl!);

    createRequestUseCase = CreateRequestUseCase(requestRepositoryImpl!);
    updateRequestUseCase = UpdateRequestUseCase(requestRepositoryImpl!);
    deleteRequestUseCase = DeleteRequestUseCase(requestRepositoryImpl!);
    getByIdUseCase = GetByIdUseCase(requestRepositoryImpl!);
    getByUserIdUseCase = GetByUserIdUseCase(requestRepositoryImpl!);
    getAllRequestUseCase = GetAllRequestUseCase(requestRepositoryImpl!);
    getByStatusUseCase = GetByStatusUseCase(requestRepositoryImpl!);
    getInProgressUseCase =  GetInProgressUseCase(requestRepositoryImpl!);
    getHistoryUseCase = GetHistoryUseCase(requestRepositoryImpl!);
    getByCaretakerIdUseCase = GetByCaretakerIdUseCase(requestRepositoryImpl!);
    //Owner

  }
}