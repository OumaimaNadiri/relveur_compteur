import 'package:assabil/models/person.dart';
import 'package:assabil/models/readingorder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/work_station_batch.dart'; // Importez le modèle WorkStationBatch

class SQLiteDatabase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _sqLiteInit();
    }
    return _database;
  }

  Future<Database> _sqLiteInit() async {
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, "assabil.db");

    Database database = await openDatabase(
      fullPath,
      onCreate: _databaseCreation,
      version: 1,
    );
    return database;
  }

  Future<void> _databaseCreation(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS USER (
      nom TEXT,
      motDePass TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS Person (
      persoN_CODE TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      firstname TEXT NOT NULL,
      profilE_CODE TEXT NOT NULL,
      phone TEXT,
      cellularphone TEXT,
      fax TEXT,
      email TEXT,
      password TEXT,
      languagE_CODE TEXT NOT NULL,
      requiredcontrolnumber INTEGER NOT NULL,
      hold INTEGER NOT NULL,  -- Changement du type de données pour 'hold'
      holD_REASON TEXT,
      userfielD1 TEXT,
      userfielD2 TEXT,
      securitylevel INTEGER NOT NULL,
      lastupdate TEXT,
      useR_CODE TEXT,
      codE_AGENCE TEXT,
      FOREIGN KEY (profilE_CODE) REFERENCES PROFILE(profilE_CODE)  -- Correction du nom de la colonne pour la clé étrangère
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS ReadingOrder(
  readingordeR_CODE TEXT PRIMARY KEY,
  workorderbatcH_CODE TEXT,
  readingordertypE_CODE TEXT,
  itinerarY_CODE TEXT,
  sequence REAL,
  creationdate TEXT,
  startdate TEXT,
  enddate TEXT,
  previousindex REAL,
  previousindexdate TEXT,
  previousindexreason_code TEXT,
  envisagedindex REAL,
  maximumindex REAL,
  minimumindex REAL,
  newindex REAL,
  newindexdate TEXT,
  executedbypersoN_CODE TEXT,
  rounD_CODE TEXT,
  num TEXT,
  streetname1 TEXT,
  streetnamE2 TEXT,
  postalcode TEXT,
  city TEXT,
  internaL_COUNTER INTEGER,
  name TEXT,
  name2 TEXT,
  contracT_CODE TEXT,
  installatioN_CODE TEXT,
  pricelisT_CODE TEXT,
  asseT_CODE TEXT,
  producT_CODE TEXT,
  serialnumber TEXT,
  information TEXT,
  externalreference TEXT,
  readingorderresulT_CODE TEXT,
  readingorderresultnotE_CODE TEXT,
  digitsnumber INTEGER,
  coefficient NUMERIC,
  zwnummer TEXT,
  zpruefkl TEXT,
  zzwtyp TEXT,
  zkennziff TEXT,
  zwert1 TEXT,
  itinerarY_CODENavigation TEXT,
  workorderbatcH_CODENavigation TEXT
)
''');


    await db.execute('''
   CREATE TABLE IF NOT EXISTS WorkStationBatch (
  workorderBatchCode TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  workstationCode TEXT NOT NULL,
  workorderBatchTypeCode TEXT,
  workorderBatchStatusCode TEXT,
  codeAgence TEXT,
  readingOrders TEXT
);

  ''');
  }
  Future<void> addColumnToReadingOrder(String columnName, String columnType) async {
  try {
    Database? myDatabase = await database;
    await myDatabase!.execute('ALTER TABLE ReadingOrder ADD COLUMN $columnName $columnType');
  } catch (e) {
    // Gérer les erreurs éventuelles
    print('Erreur lors de l\'ajout de la colonne : $e');
  }
}


  Future<List<Map<String, dynamic>>> getData(
      String sqlInsertStatement, List<dynamic> params) async {
    Database? myDatabase = await database;
    return await myDatabase!.rawQuery(sqlInsertStatement, params);
  }

  Future<int> insertData(
      String sqlInsertStatement, List<dynamic> params) async {
    Database? myDatabase = await database;
    return await myDatabase!.rawInsert(sqlInsertStatement, params);
  }

  Future<int> deleteData(String sqlDeleteStatement) async {
    Database? myDatabase = await database;
    return await myDatabase!.rawDelete(sqlDeleteStatement);
  }

  Future<int> insertPerson(Person _person) async {
    try {
      Database? myDatabase = await database;
      return await myDatabase!.insert('Person', _person.toJson());
    } catch (e) {
      return 0;
    }
  }

  Future<Person?> getPerson(String personCode) async {
    try {
      Database? myDatabase = await database;
      List<Map<String, dynamic>> result = await myDatabase!.query(
        'Person',
        where: 'persoN_CODE = ?',
        whereArgs: [personCode],
      );
      if (result.isNotEmpty) {
        return Person.fromJson(result.first);
      } else {
        return null; // Person not found
      }
    } catch (e) {
      print("Error retrieving person: $e");
      return null; // Return null if error occurs
    }
  }

  Future<int> updatePerson(Person person) async {
    try {
      Database? myDatabase = await database;
      return await myDatabase!.update(
        'Person',
        person.toJson(),
        where: 'persoN_CODE = ?',
        whereArgs: [person.personCode],
      );
    } catch (e) {
      print("Error updating person: $e");
      return 0; // Return 0 if error occurs
    }
  }

 Future<int> insertWorkstationBatchList(List<WorkStationBatch> workstationBatchList) async {
  try {
    Database? myDatabase = await database;
    Batch batch = myDatabase!.batch();

    for (var workstationBatch in workstationBatchList) {
      // Convert the WorkStationBatch instance to a map for SQLite
      Map<String, dynamic> workstationBatchMap = workstationBatch.toSqlite();

      // Check for existing entry
      List<Map<String, dynamic>> result = await myDatabase.query(
        'WorkStationBatch',
        where: 'workorderBatchCode = ?',
        whereArgs: [workstationBatch.workorderBatchCode],
      );

      if (result.isEmpty) {
        // Insert if not exists
        batch.insert('WorkStationBatch', workstationBatchMap);
      } else {
        // Update if exists
        batch.update(
          'WorkStationBatch',
          workstationBatchMap,
          where: 'workorderBatchCode = ?',
          whereArgs: [workstationBatch.workorderBatchCode],
        );
      }
    }

    List<dynamic> results = await batch.commit(noResult: true);
    // Return the number of records attempted to insert (successful or ignored)
    return results.length;
  } catch (e) {
    print('Error inserting WorkStationBatch list: $e');
    return 0;
  }
}



  Future<List<WorkStationBatch>> getWorkOrderBatchFromDatabase() async {
    try {
      Database? db =
          await database; // Récupérer la base de données et la déclarer comme nullable

      if (db != null) {
        final List<Map<String, dynamic>> workStationBatches =
            await db.query('WorkStationBatch');
        return workStationBatches
            .map((data) => WorkStationBatch.fromJson(data))
            .toList();
      } else {
        // Gérer le cas où la base de données est null
        print('Erreur: La base de données est null');
        return []; // Retourner une liste vide en cas d'erreur
      }
    } catch (e) {
      print('Erreur lors de la récupération des WorkStationBatches: $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }

 Future<int> insertOrders(List<ReadingOrder> readingOrderList) async {
  try {
    // Récupérer une référence à la base de données
    Database? myDatabase = await database;

    // Initialiser le nombre de lignes insérées
    int insertedRows = 0;

    // Démarrer une transaction pour une insertion groupée
    await myDatabase!.transaction((txn) async {
      for (var order in readingOrderList) {
        // Insérer l'ordre de lecture dans la table
        int result = await txn.insert('ReadingOrder', {
          ...order.toJson(),
          'internaL_COUNTER': order.internalCounter != null ? (order.internalCounter! ? 1 : 0) : null,
        });
        insertedRows += result;
      }
    });

    // Retourner le nombre total de lignes insérées
    return insertedRows;
  } catch (e) {
    // Gérer les erreurs éventuelles
    print('Erreur lors de l\'insertion des ordres de lecture: $e');
    return 0;
  }
}



 Future<int> insertReadingOrders(List<ReadingOrder> readingOrderList) async {
  try {
    Database? myDatabase = await database;
    await addColumnToReadingOrder('itinerarY_CODENavigation', 'TEXT');
    await addColumnToReadingOrder('workorderbatcH_CODENavigation', 'TEXT');

    int insertedRows = 0;
    await myDatabase!.transaction((txn) async {
      for (var order in readingOrderList) {
        int result = await txn.insert('ReadingOrder', order.toJson());
        insertedRows += result;
      }
    });
    return insertedRows;
  } catch (e) {
    return 0;
  }
}



  Future<List<ReadingOrder>> getOrders() async {
  try {
    Database? db = await database;
    if (db != null) {
      final List<Map<String, dynamic>> orders = await db.query('ReadingOrder');
      List<ReadingOrder> readingOrders = orders.map((data) => ReadingOrder.fromJson(data)).toList();

      // Affichage des données dans la console
      readingOrders.forEach((order) {
        print(order.toJson());
      });

      return readingOrders;
    } else {
      // Gérer le cas où la base de données est null
      print('Erreur: La base de données est null');
      return []; // Retourner une liste vide en cas d'erreur
    }
  } catch (e) {
    print('Erreur lors de la récupération des ordres de relevés: $e');
    return []; // Retourner une liste vide en cas d'erreur
  }
}


List<Map<String, dynamic>> modifiedReadingOrderCodes = [];

Future<int> updateNewIndex(String readingOrderCode, double newIndex) async {
  try {
    // Accès à la base de données pour mettre à jour l'index
    Database? myDatabase = await database;
    int rowsUpdated = await myDatabase!.update(
      'ReadingOrder',
      {'newindex': newIndex},
      where: 'readingorder_code = ?',
      whereArgs: [readingOrderCode],
    );
    return rowsUpdated;
  } catch (e) {
    print('Erreur lors de la mise à jour de newIndex: $e');
    return 0; // Retourner 0 en cas d'erreur
  }
}

// Méthode pour récupérer les ordres de lecture modifiés
List<Map<String, dynamic>> getModifiedReadingOrderCodes() {
  return modifiedReadingOrderCodes;
}


Future<List<ReadingOrder>> getReadingOrders() async {
  // Récupérer une référence à la base de données
  Database? myDatabase = await database;

  // Exécuter la requête pour récupérer les ordres de lecture
  List<Map<String, dynamic>> result = await myDatabase!.query('ReadingOrder');

  // Mapper les résultats de la requête vers une liste d'objets ReadingOrder
  List<ReadingOrder> orders = result.map((e) => ReadingOrder.fromJson(e)).toList();

  // Retourner la liste des ordres de lecture récupérés
  return orders;
}

}
