class Constants {
  static String createTable = '''
  CREATE TABLE myagenda(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descricao TEXT NOT NULL
  )


 ''';
}
