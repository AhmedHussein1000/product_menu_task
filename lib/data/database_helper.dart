import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:product_menu_task/models/product_model.dart';
import 'package:product_menu_task/core/utils/constants.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._privateConstructor();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        )
      ''');

      await db.execute("UPDATE products SET category = '${Constants.bestOffers}'");
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE categories ADD COLUMN sort_order INTEGER');
      await db.delete('categories');
      final List<Map<String, dynamic>> initialCategories = [
        {'name': Constants.bestOffers, 'sort_order': 1},
        {'name': Constants.imported, 'sort_order': 2},
        {'name': Constants.spreadableCheeses, 'sort_order': 3},
        {'name': Constants.cheeses, 'sort_order': 4},
      ];
      for (var category in initialCategories) {
        await db.insert('categories', category);
      }
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT,
        price REAL,
        category TEXT,
        quantity INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sort_order INTEGER
      )
    ''');

    // Insert initial products
    final List<ProductModel> initialProducts = [
      ProductModel(
        id: '1',
        title: 'Double Whopper',
        imageUrl: Constants.burgerImageUrl,
        price: 26.75,
        category: Constants.bestOffers,
      ),
      ProductModel(
        id: '2',
        title: 'Steakhouse XI',
        imageUrl: Constants.burgerImageUrl,
        price: 36.65,
        category: Constants.bestOffers,
      ),
      ProductModel(
        id: '3',
        title: 'Chicken Steakhouse',
        imageUrl: Constants.burgerImageUrl,
        price: 37.95,
        category: Constants.bestOffers,
      ),
      ProductModel(
        id: '4',
        title: 'Steakhouse',
        imageUrl: Constants.burgerImageUrl,
        price: 30.45,
        category: Constants.bestOffers,
      ),
      ProductModel(
        id: '5',
        title: 'Quattro Cheese Grill',
        imageUrl: Constants.burgerImageUrl,
        price: 28.75,
        category: Constants.bestOffers,
      ),
      ProductModel(
        id: '6',
        title: 'Quattro Cheese Chicken',
        imageUrl: Constants.burgerImageUrl,
        price: 28.75,
        category: Constants.bestOffers,
      ),
    ];

    for (var product in initialProducts) {
      await insertProduct(db, product);
    }

    final List<Map<String, dynamic>> initialCategories = [
      {'name': Constants.bestOffers, 'sort_order': 1},
      {'name': Constants.imported, 'sort_order': 2},
      {'name': Constants.spreadableCheeses, 'sort_order': 3},
      {'name': Constants.cheeses, 'sort_order': 4},
    ];

    for (var category in initialCategories) {
      await db.insert('categories', category);
    }
  }

  Future<int> insertProduct(Database db, ProductModel product) async {
    return await db.insert('products', product.toMap());
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return ProductModel.fromMap(maps[i]);
    });
  }

  Future<List<String>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories', orderBy: 'sort_order ASC');
    return List.generate(maps.length, (i) {
      return maps[i]['name'] as String;
    });
  }

  Future<int> updateQuantity(String id, int quantity) async {
    final db = await database;
    return await db.update(
      'products',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}