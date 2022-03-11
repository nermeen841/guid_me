// ignore_for_file: file_names

abstract class AppCubitStates {}

class AppInitialState extends AppCubitStates {}

class CreatedatabaseState extends AppCubitStates {}

class InsertdatabaseState extends AppCubitStates {}

class DeletedatabaseState extends AppCubitStates {}

class GetdatabaseState extends AppCubitStates {}

class LoadingDatafromDatabase extends AppCubitStates {}
