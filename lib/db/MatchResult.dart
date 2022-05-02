import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class MatchResult{
  var recId;
  final int myMatchPoint;
  final int youMatchPoint;
  final String myName;
  final String yourName;
  final String gameResult;

  MatchResult({
    this.recId,
    required this.myMatchPoint,
    required this.youMatchPoint,
    required this.myName,
    required this.yourName,
    required this.gameResult
  }); 
  
  Map<String, dynamic> toMap(){
    return {
      'recId':recId,
      'myMatchPoint':myMatchPoint,
      'youMatchPoint':youMatchPoint,
      'myName':myName,
      'yourName':yourName,
      'gameResult':gameResult,
    };
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(),'match_result.db'),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE match_result(recId INTEGER PRIMARY KEY AUTOINCREMENT, myPoint TEXT, myMatchPoint TEXT, youPoint TEXT"
          +", youMatchPoint TEXT, myName TEXT, yourName TEXT, gameResult TEXT)",
        );
      },
      version: 1,
    );
    return _database;
  }

  /** データの取得 */
  static Future<List<MatchResult>> getDatas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('match_result');
    return List.generate(maps.length,(i){
      return MatchResult(
        recId: maps[i]['recId'],
        myMatchPoint: int.parse(maps[i]['myMatchPoint']),
        youMatchPoint: int.parse(maps[i]['youMatchPoint']),
        myName: maps[i]['myName'],
        yourName: maps[i]['yourName'],
        gameResult: maps[i]['gameResult'],
      );
    });
  }

  /** データの取得 */
  static Future<List<MatchResult>> getDatasFromRecId(int recId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('match_result',where: "recId=?", whereArgs:[recId]);
    return List.generate(maps.length,(i){
      return MatchResult(
        recId: maps[i]['recId'],
        myMatchPoint: int.parse(maps[i]['myMatchPoint']),
        youMatchPoint: int.parse(maps[i]['youMatchPoint']),
        myName: maps[i]['myName'],
        yourName: maps[i]['yourName'],
        gameResult: maps[i]['gameResult'],
      );
    });
  }

  /** データの挿入 */
  static Future<void> insertData(MatchResult data) async {
    final Database db = await database;
    await db.insert(
      'match_result',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /** データの削除 */
  static Future<void> deleteData(int recId) async {
    final db = await database;
    await db.delete(
      'match_result',
      where: "recId = ?",
      whereArgs: [recId],
    );
  }
}
