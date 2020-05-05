import 'package:contacts/models/contact.model.dart';
import 'package:contacts/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {
  Future<Database> _getDatabase() async { // método para abrir conexão com o banco
    return openDatabase( // openDatabase => abre um banco de dados 
      join(await getDatabasesPath(), DATABASE_NAME), // getDatabasesPath retorna o caminho do banco (com o join mais o getDatabasesPath é a união entre o caminho e o nome do banco)
      onCreate: (db, version) { // caso o banco não exista é executado a função de criação de banco
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future create(ContactModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
        TABLE_NAME, // nome da tabela 
        model.toMap(), // valores salvos na tabela, que foram passados de forma dinamica pela model de Contact
        conflictAlgorithm: ConflictAlgorithm.replace // caso tenha conflito, terá um replace
      );
    }
    catch(ex) {
      print(ex);
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME); // busca todos os dados da tabela

      return List.generate(
        maps.length, 
        (i) {
          return ContactModel(
            id: maps[i]['id'],
            name: maps[i]['name'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
            image: maps[i]['image'],
            addressLine1: maps[i]['addressLine1'],
            addressLine2: maps[i]['addressLine2'],
            latLng: maps[i]['latLng']
          );
        }
      );
    }
    catch(ex) {
      print(ex);
      return new List<ContactModel>();
    }
  }

  Future<List<ContactModel>> search(String term) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "name LIKE ?", // o "?" busca dentro do whereArgs oq será utilizado na pesquisa, caso tenha mais de um args, ele busca pela posição inicial
        whereArgs: [
          '%$term%', // o % diz onde pesquisar, se for apenas um % no começo do parametro, ele pesquisa a primeira palavra do nome, se for no fim o %, pesquisa a ultima, e dois % pesquisa no meio
        ],
      );

      return List.generate(
        maps.length, 
        (i) {
          return ContactModel(
            id: maps[i]['id'],
            name: maps[i]['name'],
            phone: maps[i]['phone'],
            email: maps[i]['email'],
            image: maps[i]['image'],
            addressLine1: maps[i]['addressLine1'],
            addressLine2: maps[i]['addressLine2'],
            latLng: maps[i]['latLng']
          );
        }
      );
    }
    catch(ex) {
      print(ex);
      return new List<ContactModel>();
    }
  }

  Future<ContactModel> getContact(int id) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [
          id
        ]
      );
      
      return ContactModel(
        id: maps[0]['id'],
        name: maps[0]['name'],
        phone: maps[0]['phone'],
        email: maps[0]['email'],
        image: maps[0]['image'],
        addressLine1: maps[0]['addressLine1'],
        addressLine2: maps[0]['addressLine2'],
        latLng: maps[0]['latLng']
      );
    }
    catch(ex) {
      print(ex);
      return new ContactModel();
    }
  } 

  Future update(ContactModel model) async {
    try {
      final Database db = await _getDatabase();

      await db.update(
        TABLE_NAME, 
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id]
      );
    }
    catch(ex) {
      print(ex);
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database db = await _getDatabase();
      db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [
          id
        ]
      );
    }
    catch(ex) {
      print(ex);
      return;
    }
  }

  Future updateImage(int id, String imagePath) async {
    try {
      final Database db = await _getDatabase();
      final model = await getContact(id);

      model.image = imagePath;

      await db.update(
        TABLE_NAME, 
        model.toMap(),
        where: "id = ?",
        whereArgs: [
          model.id
        ]
      );
    }
    catch(ex) {
      print(ex);
      return;
    }
  }
}