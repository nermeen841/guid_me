// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'appState.dart';

class DataBaseCubit extends Cubit<AppCubitStates> {
  DataBaseCubit() : super(AppInitialState());

  static DataBaseCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> favourites = [];
  Map<int, bool> isfavourite = {};

  void createDb() {
    openDatabase('favourite.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE favourite (id INTEGER PRIMARY KEY , bookNameEn TEXT, bookNameAr TEXT,  bookImage TEXT , bookID INTEGER, writerNameEn TEXT , writerNameAr TEXT, bookPrice TEXT)')
          .then((value) {})
          .catchError((error) {});
    }, onOpen: (database) {
      getfromDataBase(database);
      print("database created successfully ");
    }).then((value) {
      database = value;
      emit(CreatedatabaseState());
    });
  }
/////////////////////////////////////////////////////////////////////////

  getfromDataBase(database) {
    emit(LoadingDatafromDatabase());
    database.rawQuery('SELECT * FROM favourite').then((value) {
      favourites = value;
      for (var element in favourites) {
        isfavourite[element['bookID']] = true;
      }
      emit(GetdatabaseState());
    });
  }
////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////

  deletaFromDB({required int id}) {
    database.rawDelete('DELETE FROM favourite WHERE bookID = ?', ['$id']).then(
        (value) {
      getfromDataBase(database);
      isfavourite[id] = false;
      print("item deleted successfully ");
      emit(DeletedatabaseState());
    }).catchError((error) {});
  }

////////////////////////////////////////////////////////////////////////////////////////////

  void inserttoDatabase(
      {required String booknameEn,
      required String bookImage,
      required String booknameAr,
      required String writernameEn,
      required String writernameAr,
      required int bookId,
      required String price}) async {
    database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO favourite(bookNameEn , bookNameAr , bookImage , bookID , writerNameEn , writerNameAr , bookPrice) VALUES("$booknameEn", "$booknameAr", "$bookImage", "$bookId", "$writernameEn", "$writernameAr" , "$price")')
          .then((value) {
        isfavourite[bookId] = true;
        emit(InsertdatabaseState());
        print("item inserted successfully ");
        getfromDataBase(database);
        emit(GetdatabaseState());
      }).catchError((error) {});
      return null;
    });
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////



