import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //import these

import '../models/contacts.dart';

//CRUD = CRETAE,READ,UPDATE,DELETE


class DBHelper {
  //Isso é para inicializar o banco de dados SQlite
  //O banco de dados é um pacote sqlite bem como getDatabasesPath()
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'contacts.db');
    //Isso é para criar o banco de dados(CREATE)
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //CREATE
  static Future _onCreate(Database db, int version) async {
    //Isso é para criar uam tabela no banco de dados
    //O comando é o mesmo que a isntrução do sql
    final sql = '''CREATE TABLE contacts(
      id INTEGER PRIMARY KEY,
      name TEXT,
      contact TEXT
    )''';
    await db.execute(sql);
  }

  //Função para insert (INSERT)
  static Future<int> createContacts(Contact contact) async {
    Database db = await DBHelper.initDB();
    //Criando contato usando o insert()
    return await db.insert('contacts', contact.toJson());
  }

  //Função para ler(READ)
  static Future<List<Contact>> readContacts() async {
    Database db = await DBHelper.initDB();
    var contact = await db.query('contacts', orderBy: 'name');
    //this is to list out the contact list from database
    //if empty, then return empty []
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((details) => Contact.fromJson(details)).toList()
        : [];
    return contactList;
  }

  //Função de Update(UPDATE)
  static Future<int> updateContacts(Contact contact) async {
    Database db = await DBHelper.initDB();
    //update the existing contact
    //according to its id
    return await db.update('contacts', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  //Função de Delte(DELETE)
  static Future<int> deleteContacts(int id) async {
    Database db = await DBHelper.initDB();
    //delete existing contact
    //according to its id
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
