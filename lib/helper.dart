import 'package:sqflite/sqflite.dart';
 import 'package:path/path.dart';

 class DBHelper {
   //INICIALIZAÇÃO DO SQLITE 
  static Future<Database> initDB() async {
     var dbPath = await getDatabasesPath();
     String path = join(dbPath,'contacts.db');
     return await openDatabase(path, version: 1, onCreate: _onCreate );
    }

  // criação de função _onCreate 
  static Future _onCreate(Database db, int version) async {
      final sql = ''' CREATE TABLE contact(
      id INTEGER PRIMARY KEY,
      name TEXT,
      contact TEXT
      )''';
      await db.execute(sql);
    }
  // criação da função de INSERT
  static Future<int> createContacts(){
    return;
  }
 }