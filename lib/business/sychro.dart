import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:assabil/sqlite/data_acces.dart';
import '../services/api.dart';

class Synchronization {
  final SQLRequest _sqlRequest = SQLRequest();

 
   Future<void> importDataFromServer() async {
  try {
    // Récupérer les données depuis l'API
    final orders = await getReadingOrder('1');
    final workorderbatchs = await getWorkStationBatch('1');

    if (orders.isNotEmpty) {
      // Insérer les données dans la base de données SQLite
      await _sqlRequest.insertOrders(orders);

      // Afficher les données importées
      final importedOrders = await _sqlRequest.getOrders(); // Supposons que cette méthode récupère les données de la base de données
      print('Données importées depuis la base de données : $importedOrders');

    } else {
      

      print('Erreur lors de l\'importation des données : aucune donnée récupérée depuis l\'API');
    }
    if (workorderbatchs.isNotEmpty) {
      // Insérer les données dans la base de données SQLite
      await _sqlRequest.insertWorkstationBatchList(workorderbatchs);

      // Afficher les données importées
      final importedbatches = await _sqlRequest.getWorkOrderBatchFromDatabase(); // Supposons que cette méthode récupère les données de la base de données
      print('Données importées depuis la base de données : $importedbatches');

    } else {
      print('Erreur lors de l\'importation des données : aucune donnée récupérée depuis l\'API');
    }

  } catch (e) {
    print('Erreur lors de l\'importation des données : $e');
  }
}


 Future<void> exportModifiedReadingOrders(List<Map<String, dynamic>> modifiedOrderCodes) async {
    try {
      // Convertir les codes d'ordre de lecture modifiés en un format approprié pour l'envoi
      var modifiedOrdersJson = modifiedOrderCodes.map((code) => {'readingOrderCode': code}).toList();

      // Envoyer les données des ordres de lecture modifiés à votre API
      var response = await http.post(
        Uri.parse('http://10.0.2.2:5055/api/GetConfigTable/UpdateReadingOrderNewIndex'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(modifiedOrdersJson),
      );

      if (response.statusCode == 200) {
        print('Ordres de lecture modifiés exportés avec succès.');
      } else {
        print('Échec de lexportation des ordres de lecture modifiés. Code de statut: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de lexportation des ordres de lecture modifiés: $e');
    }
  }

}
