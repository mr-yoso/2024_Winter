import 'user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "userdb.db";
  static const _databaseVersion = 1;
  static const table = 'users_table';
  static const columnId = 'id';
  static const columnFirstName = 'firstName';
  static const columnLastName = 'lastName';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // Open the database and create the table if it doesn't exist.
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFirstName TEXT NOT NULL,
            $columnLastName TEXT NOT NULL
          )
          ''');
  }

  // Insert a user into the database
  Future<int?> insertUser(User user) async {
    Database? db = await instance.database;
    return await db?.insert(table, user.toMap()); // Use toMap for consistency
  }

  // Retrieve all users from the database
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  // Function to get a list of Users instead of Maps
  Future<List<User>?> queryAllUsers() async {
    final allRows = await queryAllRows();
    return allRows?.map((row) => User.fromMap(row)).toList();
  }

  // Delete a user from the database
  Future<int?> deleteUser(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  // Update a user in the database
  Future<int?> updateUser(User user) async {
    Database? db = await instance.database;
    return await db?.update(
      table,
      user.toMap(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }
}
