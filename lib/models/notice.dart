class Notice {
  Notice({
    required this.readingorderresulTCODE,
    required this.readingorderresultnotECODE,
    required this.name,
     this.readingorderresulTCODENavigation,
  });
  late final String readingorderresulTCODE;
  late final String readingorderresultnotECODE;
  late final String name;
  late final Null readingorderresulTCODENavigation;
  
  Notice.fromJson(Map<String, dynamic> json){
    readingorderresulTCODE = json['readingorderresulT_CODE'];
    readingorderresultnotECODE = json['readingorderresultnotE_CODE'];
    name = json['name'];
    readingorderresulTCODENavigation = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['readingorderresulT_CODE'] = readingorderresulTCODE;
    _data['readingorderresultnotE_CODE'] = readingorderresultnotECODE;
    _data['name'] = name;
    _data['readingorderresulT_CODENavigation'] = readingorderresulTCODENavigation;
    return _data;
  }
}