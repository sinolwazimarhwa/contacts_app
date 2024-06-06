// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class AppDatabase{
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;
  AppDatabase._();

  //Database? _database;

  Future <Database> get database async{
    if(_dbOpenCompleter == null){
      _dbOpenCompleter=Completer();
      _opendDatabase();
      AppDatabase._();
    }
    return _dbOpenCompleter!.future;
  }

  Future _opendDatabase() async {
    final appDocumentDir= await getApplicationDocumentsDirectory();
    final dbPath= join(appDocumentDir.path, 'contacts.db');
    final database= await databaseFactoryIo.openDatabase(dbPath);
    return _dbOpenCompleter!.complete(database);
  }
}