import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/model.note.dart';
import 'package:my_hospital_app/model/model.symp_intensity.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqfliteServices {
  static Future<Database> dbInit() async {
    //initiate db
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'app.db');

    //delete the Database
    // await deleteDatabase(path);

    return await openDatabase(
      //open the database or create a database if there isn't any
      path,
      version: MaaData.VERSION,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE ${MaaData.TABLE_NAMES[0]} (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, note TEXT)");
        await db.execute(
            "CREATE TABLE ${MaaData.TABLE_NAMES[2]} (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, symptoms TEXT)");
      },
    );
  }

  static Future<int> addNote(NoteModel noteModel) async {
    // return number of items inserted as int
    final db = await SqfliteServices.dbInit();
    return db.insert(
      MaaData.TABLE_NAMES[0],
      noteModel.toMap(), //toMap fuch from NoteModel
      conflictAlgorithm: ConflictAlgorithm
          .ignore, // ignores conflictAlgo due to duplicate entries
    );
  }

  static Future<int> addSympIntensity(
      SympIntenSityModel sympIntenSityModel) async {
    final db = await SqfliteServices.dbInit();
    return db.insert(MaaData.TABLE_NAMES[2], sympIntenSityModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<NoteModel>> mFetchNotes() async {
    // returns the memos as a list (array)
    final db = await SqfliteServices.dbInit();
    // query all the rows in a table as an array of maps
    // final maps = await db.query("SELECT * FROM momnote");
    final maps = await db.rawQuery("SELECT * FROM ${MaaData.TABLE_NAMES[0]}");

    // print(maps.length);
    return List.generate(maps.length,
        // create a list of notes
        (index) {
      return NoteModel(
          date: maps[index]['date'].toString(),
          note: maps[index]['note'].toString());
    });
  }

  static Future<List<NoteModel>> mFetchCurrentNote(String currentDate) async {
    // returns the memos as a list (array)
    final db = await SqfliteServices.dbInit();
    // query all rows belonging an specific date in a table as an array of maps

    final maps = await db.rawQuery(
        "SELECT date, note FROM ${MaaData.TABLE_NAMES[0]} WHERE date = '$currentDate' GROUP BY date");
    // await db.rawQuery("SELECT date, note FROM ${MaaData.TABLE_NAMES[0]} WHERE date = '$currentDate'  GROUP BY date ORDER BY date DESC");

    // print(maps.length);
    return List.generate(maps.length,
        // create a list of notes
        (index) {
      return NoteModel(
          date: maps[index]['date'].toString(),
          note: maps[index]['note'].toString());
    });
  }

  static Future<List<SympIntenSityModel>> mFetchCurrentSympIntensity(
      String currentDate) async {
    final db = await SqfliteServices.dbInit();

    final maps = await db.rawQuery(
        "SELECT date, symptoms FROM ${MaaData.TABLE_NAMES[2]} WHERE date = '$currentDate' GROUP BY date");

    return List.generate(maps.length, (index) {
      return SympIntenSityModel(
          date: maps[index]['date'].toString(),
          symptoms: maps[index]['symptoms'].toString());
    });
  }
}
