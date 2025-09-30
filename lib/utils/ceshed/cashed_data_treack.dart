import 'package:playem/utils/media.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class CashedDataTreack {
  
  //create or open a new database
    static Future<Database> createDataBase() async{
        return await openDatabase(
            "music_List.db",
            version: 1,
            onCreate: (db, version) async {
              await db.execute('CREATE TABLE music (id INTEGER PRIMARY KEY, title TEXT, imageUrl TEXT, artist VARCAR(255), updatedAt TEXT)');
            },
        );
    }


 // new music create to the database
    static Future createMusicDataBase(Media media) async{
        var db = await createDataBase();
        return await db.insert(
            "music", {
              "id":media.streamUrl,
              "title":media.title,
              "artist":media.artist,
              "imageUrl":media.imageUrl
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
            
    }

  // read all music from the local database\
    static Future<List<Map<String,dynamic>>> getMedia() async{
      var db = await createDataBase();
      return await db.query("news",orderBy: 'updatedAt DESC', limit: 10);

    } 
}