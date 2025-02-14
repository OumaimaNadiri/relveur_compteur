import 'package:assabil/models/readingorder.dart';
import 'package:assabil/models/work_station_batch.dart';

import '../models/person.dart';
import 'Sqllite_database.dart';

class SQLRequest {
  final SQLiteDatabase _database = SQLiteDatabase();

  Future<int> insertPerson(Person person) async {
    return _database.insertPerson(person);
  }

  Future<Person?> getPerson(String personCode) async {
    return _database.getPerson(personCode);
  }

  Future<int> insertWorkstationBatchList(List<WorkStationBatch> workstationBatchList) async {
    return _database.insertWorkstationBatchList(workstationBatchList);
  }

  Future<List<WorkStationBatch>> getWorkOrderBatchFromDatabase() async {
    return _database.getWorkOrderBatchFromDatabase();
  }

   Future<int> insertOrders(List<ReadingOrder> orders) async {
    return _database.insertOrders(orders);
  }
   Future<int> insertReadingOrders(List<ReadingOrder> orders) async {
    return _database.insertReadingOrders(orders);
  }

  Future<List<ReadingOrder>> getOrders() async {
    return _database.getOrders();
  }
  Future<List<ReadingOrder>> getReadingOrders() async {
    return _database.getReadingOrders();
  }

  Future<int> updateNewIndex(String readingOrderCode, double newIndex) async {
 return _database.updateNewIndex(readingOrderCode,newIndex);
}
List<Map<String, dynamic>> getModifiedReadingOrderCodes() {
    return _database.getModifiedReadingOrderCodes();
  }
}
