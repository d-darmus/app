import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MyDataModel{
  final int id;
  final String text;

  MyDataModel({
    required this.id,
    required this.text
  }); 
  
  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'text':text,
    };
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(),'memo_database.db'),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE mydata(id INTEGER PRIMARY KEY, text TEXT)",
        );
      },
      version: 1,
    );
    return _database;
  }

  /** データの取得 */
  static Future<List<MyDataModel>> getDatas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mydata');
    return List.generate(maps.length,(i){
      return MyDataModel(
        id: maps[i]['id'],
        text: maps[i]['text'],
      );
    });
  }

  /** データの挿入 */
  static Future<void> insertData(MyDataModel data) async {
    final Database db = await database;
    await db.insert(
      'mydata',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /** データの削除 */
  static Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete(
      'mydata',
      // where: "id = ?",
      // whereArgs: [id],
    );
  }
}
