import 'package:animeworld/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBHelper {

  DBHelper._privateContructor();
  static final DBHelper instance = DBHelper._privateContructor();

  static SharedPreferences? _db;

  //! Get database
  Future<SharedPreferences> get database async {
    if (_db != null) return _db!;

    _db = await _initDB();
    return _db!;
  }

  //! Initialize database
  Future<SharedPreferences> _initDB() async {
    _db = await SharedPreferences.getInstance();
    return _db!;
  }

  // Theme mode
  Future<bool> get isDarkMode async {
    final db = await instance.database;
    return db.getBool(Constants.isDarkMode) ?? false;
  }

  Future<bool> setDarkMode(bool isDark) async {
    final db = await instance.database;
    return await db.setBool(Constants.isDarkMode, isDark);
  }

  Future<bool> get isEnglish async {
    final db = await instance.database;
    return db.getBool(Constants.isEnglish) ?? false;
  }

  Future<bool> setIsEnglish(bool isEnglish) async {
    final db = await instance.database;
    return await db.setBool(Constants.isEnglish, isEnglish);
  }
}