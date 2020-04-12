import 'package:bubble_diary/models/entry.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBService {

		static Database _database;

		final String table = "entries";

		Future<Database> get db async {
				if(_database != null) return _database;
				_database = await initDB();
				return _database;
		}

		initDB() async {
				var directory = await getDatabasesPath();
				String path = join(directory, "bubble.db");
				var database = await openDatabase(
						path,
						version: 1,
						onCreate: (Database _db, int version) async {
								await _db.execute(
										"CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT, date INTEGER, title TEXT, content TEXT)"
								);
						},
				);
				return database;
		}
		
		
		Future add(Entry entry) async {
				var database = await db;
				database.insert(table, entry.toMap());
		}

		Future update(Entry entry) async {
				var database = await db;
				database.update(table, entry.toMap(), where: "id = ?", whereArgs: [entry.id]);
		}

		Future delete(Entry entry) async {
				var database = await db;
				database.delete(table, where: "id = ?", whereArgs: [entry.id]);
		}

		Future getEntries(int date) async {
				var database = await db;
				List<Map<String, dynamic>> maps = await database.query(table, where: "date = ?", whereArgs: [date]);
				List<Entry> entryList = new List<Entry>();
				for(Map<String, dynamic> map in maps) {
						entryList.add(Entry.fromMap(map));
				}
				return entryList;
		}

}