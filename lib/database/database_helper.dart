import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_primeiro_banco_sozinho/model/agenda_model.dart';
import 'package:sqflite_primeiro_banco_sozinho/utilities/constants.dart';

class DataBaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  Future initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'agenda.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(Constants.createTable);
  }

  Future<AgendaModel> adicionar(AgendaModel agendaModel) async {
    var dbClient = await db;
    await dbClient?.insert('myagenda', agendaModel.toMap());
    return agendaModel;
  }

  Future<List<AgendaModel>> getDataList() async {
    await db;
    final List<Map<String, dynamic>> resultado =
        await _db!.rawQuery('SELECT * FROM myagenda');
    return resultado.map((e) => AgendaModel.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('myagenda', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(AgendaModel agendaModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'myagenda',
      agendaModel.toMap(),
      where: 'id = ?',
      whereArgs: [agendaModel.id],
    );
  }
}
