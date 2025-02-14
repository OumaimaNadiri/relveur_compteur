import '../models/person.dart';
import 'package:flutter/material.dart';

class PersonProvider extends ChangeNotifier {
  late Person _person;

  Person get person => _person;

  setPerson(Person person) {
    _person = person;
    notifyListeners();
  }
}