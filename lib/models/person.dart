class Person {
  late final String personCode;
  late final String name;
  late final String firstName;
  late final String profileCode;
  late final String? phone;
  late final String? cellularPhone;
  late final String? fax;
  late final String? email;
  late final String password;
  late final String languageCode;
  late final int requiredControlNumber;
  late final bool hold;
  late final String? holdReason;
  late final String? userField1;
  late final String? userField2;
  late final int securityLevel;
  late final String? lastUpdate;
  late final String? userCode;
  late final String codeAgence;

  Person({
    required this.personCode,
    required this.name,
    required this.firstName,
    required this.profileCode,
    required this.phone,
    this.cellularPhone,
    this.fax,
    this.email,
    required this.password,
    required this.languageCode,
    required this.requiredControlNumber,
    required this.hold,
    this.holdReason,
    this.userField1,
    this.userField2,
    required this.securityLevel,
    this.lastUpdate,
    this.userCode,
    required this.codeAgence,
  });

  Person.fromJson(Map<String, dynamic> json)
      : personCode = json['persoN_CODE'],
        name = json['name'],
        firstName = json['firstname'],
        profileCode = json['profilE_CODE'],
        phone = json['phone'],
        cellularPhone = json['cellularphone'],
        fax = json['fax'],
        email = json['email'],
        password = json['password'],
        languageCode = json['languagE_CODE'],
        requiredControlNumber = json['requiredcontrolnumber'],
        hold = json['hold'] == 1,
        holdReason = json['holD_REASON'],
        userField1 = json['userfielD1'],
        userField2 = json['userfielD2'],
        securityLevel = json['securitylevel'],
        lastUpdate = json['lastupdate'],
        userCode = json['useR_CODE'],
        codeAgence = json['codE_AGENCE'];

  Map<String, dynamic> toJson() {
    return {
      'persoN_CODE': personCode,
      'name': name,
      'firstname': firstName,
      'profilE_CODE': profileCode,
      'phone': phone,
      'cellularphone': cellularPhone,
      'fax': fax,
      'email': email,
      'password': password,
      'languagE_CODE': languageCode,
      'requiredcontrolnumber': requiredControlNumber,
      'hold': hold,
      'holD_REASON': holdReason,
      'userfielD1': userField1,
      'userfielD2': userField2,
      'securitylevel': securityLevel,
      'lastupdate': lastUpdate,
      'useR_CODE': userCode,
      'codE_AGENCE': codeAgence,
    };
  }
}
