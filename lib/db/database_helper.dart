import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT
      );
    """);

    await db.execute("""
      CREATE TABLE recipes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        ingredients TEXT,
        description TEXT,
        imagePath TEXT
      );
    """);
  }

  Future<int> register(String email, String password) async {
    var dbClient = await db;
    return await dbClient.insert("users", {"email": email, "password": password});
  }

  Future<Map?> login(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.query(
      "users",
      where: "email=? AND password=?",
      whereArgs: [email, password]
    );
    return res.isNotEmpty ? res.first : null;
  }

  Future<int> addRecipe(Map<String, dynamic> recipe) async {
    var dbClient = await db;
    return await dbClient.insert('recipes', recipe);
  }

  Future<List<Map<String, dynamic>>> getRecipes() async {
    var dbClient = await db;
    // Mengambil resep terbaru di atas
    return await dbClient.query('recipes', orderBy: 'id DESC');
  }
}
