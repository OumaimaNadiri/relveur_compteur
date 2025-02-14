import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart';

part 'readingorder.g.dart';

@JsonSerializable()
class ReadingOrder {
  @JsonKey(name: 'readingordeR_CODE')
  final String readingorderCode;
  @JsonKey(name: 'workorderbatcH_CODE')
  final String? workorderbatchCode;
  @JsonKey(name: 'readingordertypE_CODE')
  final String? readingordertypeCode;
  @JsonKey(name: 'itinerarY_CODE')
  final String? itineraryCode;
  @JsonKey(name: 'sequence', fromJson: _toDouble)
  final double? sequence;
  @JsonKey(name: 'creationdate')
  final String? creationdate;
  @JsonKey(name: 'startdate')
  final String? startdate;
  @JsonKey(name: 'enddate')
  final String? enddate;
  @JsonKey(name: 'previousindex', fromJson: _toDouble)
  final double? previousindex;
  @JsonKey(name: 'previousindexdate')
  final String? previousindexdate;
  @JsonKey(name: 'previousindexreasoN_CODE')
  final String? previousindexreasonCode;
  @JsonKey(name: 'envisagedindex', fromJson: _toDouble)
  final double? envisagedindex;
  @JsonKey(name: 'maximumindex', fromJson: _toDouble)
  final double? maximumindex;
  @JsonKey(name: 'minimumindex', fromJson: _toDouble)
  final double? minimumindex;
  @JsonKey(name: 'newindex', fromJson: _toDouble)
   double? newIndex;
  @JsonKey(name: 'newindexdate')
  final String? newindexdate;
  @JsonKey(name: 'executedbypersoN_CODE')
  final String? executedbypersonCode;
  @JsonKey(name: 'rounD_CODE')
  final String? roundCode;
  @JsonKey(name: 'streetnamE1')
  final String? streetname1;
  @JsonKey(name: 'streetnamE2')
  final String? streetname2;
  @JsonKey(name: 'postalcode')
  final String? postalcode;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'internaL_COUNTER', fromJson: _toBool)
  final bool? internalCounter;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'namE2')
  final String? name2;
  @JsonKey(name: 'contracT_CODE')
  final String? contractCode;
  @JsonKey(name: 'installatioN_CODE')
  final String? installationCode;
  @JsonKey(name: 'pricelisT_CODE')
  final String? pricelistCode;
  @JsonKey(name: 'asseT_CODE')
  final String? assetCode;
  @JsonKey(name: 'producT_CODE')
  final String? productCode;
  @JsonKey(name: 'serialnumber')
  final String? serialnumber;
  @JsonKey(name: 'information')
  final String? information;
  @JsonKey(name: 'externalreference')
  final String? externalreference;
  @JsonKey(name: 'readingorderresulT_CODE')
  final String? readingorderresultCode;
  @JsonKey(name: 'readingorderresultnotE_CODE')
  final String? readingorderresultnoteCode;
  @JsonKey(name: 'digitsnumber')
  final int? digitsnumber;
  @JsonKey(name: 'coefficient', fromJson: _parseDecimal, toJson: _formatDecimal)
  final Decimal? coefficient;
  @JsonKey(name: 'zwnummer')
  final String? zwnummer;
  @JsonKey(name: 'zpruefkl')
  final String? zpruefkl;
  @JsonKey(name: 'zzwtyp')
  final String? zzwtyp;
  @JsonKey(name: 'zkennziff')
  final String? zkennziff;
  @JsonKey(name: 'zwerT1')
  final String? zwert1;
  @JsonKey(name: 'itinerarY_CODENavigation')
  final String? itinerarycodenavigation;
  @JsonKey(name: 'workorderbatcH_CODENavigation')
  final String? workorderbatchcodenavigation;

  ReadingOrder({
    required this.readingorderCode,
    required this.workorderbatchCode,
    this.readingordertypeCode,
    this.itineraryCode,
    this.sequence,
    this.creationdate,
    this.startdate,
    this.enddate,
    this.previousindex,
    this.previousindexdate,
    this.previousindexreasonCode,
    this.envisagedindex,
    this.maximumindex,
    this.minimumindex,
    this.newIndex,
    this.newindexdate,
    this.executedbypersonCode,
    this.roundCode,
    this.streetname1,
    this.streetname2,
    this.postalcode,
    this.city,
    this.internalCounter,
    this.name,
    this.name2,
    this.contractCode,
    this.installationCode,
    this.pricelistCode,
    this.assetCode,
    this.productCode,
    this.serialnumber,
    this.information,
    this.externalreference,
    this.readingorderresultCode,
    this.readingorderresultnoteCode,
    this.digitsnumber,
    this.coefficient,
    this.zwnummer,
    this.zpruefkl,
    this.zzwtyp,
    this.zkennziff,
    this.zwert1,
    this.itinerarycodenavigation,
    this.workorderbatchcodenavigation,
  });

  factory ReadingOrder.fromJson(Map<String, dynamic> json) => _$ReadingOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingOrderToJson(this);



  // Fonctions d'assistance pour la conversion des types
  static Decimal? _parseDecimal(dynamic value) {
    if (value == null) return null;
    if (value is int || value is double) {
      return Decimal.parse(value.toString());
    }
    return Decimal.parse(value as String);
  }

  // Fonction pour la sérialisation de Decimal
  static dynamic _formatDecimal(Decimal? decimal) {
    return decimal?.toString();
  }

  static double? _toDouble(dynamic value) => value == null ? null : (value is int ? value.toDouble() : value);
  static bool? _toBool(dynamic value) => value == null ? null : value == 1;
}
