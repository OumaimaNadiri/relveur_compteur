
import '../models/person.dart';
import '../sqlite/Data_acces.dart';
import '../services/api.dart';

class Authentication {
  final SQLRequest _sqlRequest = SQLRequest();

  Future<Person?> authenticateUser(String matricule, String password) async {
    try {
      // Vérifier d'abord dans la base de données locale
      Person? localUser = await _sqlRequest.getPerson(matricule);

      if (localUser != null) {
        // L'utilisateur existe localement, vérifier le mot de passe
        if (localUser.password == password) {
          // Authentification réussie
          return localUser;
        } else {
          // Mot de passe incorrect
          return null;
        }
      } else {
        // L'utilisateur n'existe pas localement, vérifier via API
        List<Person> apiResponse = await authenticateViaAPI(matricule, password);

        if (apiResponse.isNotEmpty) {
          // Authentification réussie via API, enregistrer localement l'utilisateur
          await _sqlRequest.insertPerson(apiResponse[0]);
          return apiResponse[0];
        } else {
          // Informations d'identification incorrectes
          return null;
        }
      }
    } catch (e) {
      // Erreur lors de l'authentification
      return null;
    }
  }

  Future<List<Person>> authenticateViaAPI(String matricule, String password) async {
    try {
      // Appeler l'API pour vérifier l'authentification
      return await getNPerson(matricule, password);
    } catch (e) {
      throw Exception("Erreur lors de l'appel de l'API");
    }
  }


 
}
