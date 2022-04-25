import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:teste_sqlite/models/contacts.dart';


//CRUD - CREATE,READ,UPDATE,DELETE

 class DBHelper {
   //INICIALIZAÇÃO DO SQLITE 
  static Future<Database> initDB() async {
     var dbPath = await getDatabasesPath();
     String path = join(dbPath,'contacts.db');
     return await openDatabase(path, version: 1, onCreate: _onCreate );
    }

  // criação de função _onCreate(CREATE)
  static Future _onCreate(Database db, int version) async {
      final sql = ''' CREATE TABLE contact(
      id INTEGER PRIMARY KEY,
      name TEXT,
      contact TEXT
      )''';
      await db.execute(sql);
    }
  // criação da função de insert(INSERT)
  static Future<int>createContacts(Contact contact)async{
    Database db = await DBHelper.initDB();  
    //cria contact usando insert()
    return db.insert("contacts", contact.toJson());
  }

  //criação da função de leitura(READ)
  static Future<List<Contact>> readContacts()async{
    Database db = await DBHelper.initDB();
    var contact = await db.query('contacts',orderBy: 'name');
    // retorna uma lista de contatos do banco de dados
    // Se a lista está vazia, reotrna vazia []
    List<Contact> contactList = contact.isNotEmpty ?
    contact.map((details) => Contact.fromJson(details)).toList() : [];
    return contactList;
  }

  //criação da função de update(UPDATE)
  static Future<int> updateContacts(Contact contact)async{
    Database db = await DBHelper.initDB();
    //Update no contact existente de acordo com o id
    return await db.update('contacts', contact.toJson(), 
    where:'id = ?',whereArgs: [contact.id]);
  }

  //criação dafunção de delete(DELETE)
  static Future<int> deleteContacts(int id)async{
    Database db = await DBHelper.initDB();
    //deleta o contact existente de acordo com o id
    return await db.delete('contacts', where: 'id = ?',whereArgs: [id]);
  }

 }