import 'package:assabil/models/readingorder.dart';
import 'package:assabil/models/work_station_batch.dart';
import '../models/person.dart';
import 'package:assabil/models/Notice.dart';import 'package:dio/dio.dart';

Future<List<Notice>> getNotice() async {
  return _fetchData<Notice>('http://localhost:5055/api/GetConfigTable/Notices', (responseData) {
    return responseData.map((e) => Notice.fromJson(e)).toList();
  });
}

Future<List<ReadingOrder>> getReadingOrder(String matricule) async {
  try {
    // Effectuer la requête HTTP
    final response = await Dio().get('http://localhost:5055/api/GetConfigTable/ReadingOrder?Matricule=$matricule');

    // Vérifier si la requête a réussi
    if (response.statusCode == 200) {
      // Afficher les données brutes avant la désérialisation
      print('Raw Data (Before Deserialization): ${response.data}');

      // Désérialiser les données
      final List<dynamic> responseData = response.data;
      final List<ReadingOrder> readingOrders = responseData.map((e) => ReadingOrder.fromJson(e)).toList();

      // Afficher les données désérialisées
      print('Deserialized Data: $readingOrders');

      return readingOrders;
    } else {
      throw Exception('Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    // Gérer les erreurs
    print('Error: $e');
    throw Exception('Failed to load data: $e');
  }
}

Future getAllReadingOrders() async {
  return _fetchData<ReadingOrder>('http://10.0.2.2:5055/api/GetConfigTable/AllReadingOrders', (responseData) {
    return responseData.map((e) => ReadingOrder.fromJson(e)).toList();
  });
}

Future<List<Person>> getNPerson(String matricule, String password) async {
  return _fetchData<Person>('http://localhost:5055/api/GetConfigTable/Authentification?Matricule=$matricule&Password=$password', (responseData) {
    return responseData.map((e) => Person.fromJson(e)).toList();
  });
}


Future<List<WorkStationBatch>> getWorkStationBatch(String matricule) async {
  return _fetchData<WorkStationBatch>('http://localhost:5055/api/GetConfigTable/WorkOrderBath?Matricule=$matricule', (responseData) {
    return responseData.map((e) => WorkStationBatch.fromJson(e)).toList();
  });
}
Future<List<ReadingOrder>> getWorkOrderBatchReadingOrders(String workOrderBatchCode) async {
  return _fetchData<ReadingOrder>('http://localhost:5055/api/GetConfigTable/WorkOrderBatchReadingOrders/$workOrderBatchCode', (responseData) {
    return responseData.map((e) => ReadingOrder.fromJson(e)).toList();
  });
}

Future<List<T>> _fetchData<T>(String url, List<T> Function(List<dynamic>) parser) async {
  final dio = Dio();
  try {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data;
      return parser(responseData);
    } else {
      throw Exception("Failed to load data, status code: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Failed to load data: $e");
  }
}

