import 'package:json_annotation/json_annotation.dart';
import 'package:assabil/models/readingorder.dart';
import 'dart:convert';

part 'work_station_batch.g.dart';

@JsonSerializable()
class WorkStationBatch {
  @JsonKey(name: 'workorderbatcH_CODE')
  final String workorderBatchCode;
  @JsonKey(name: 'thedate')
  final DateTime theDate;
  @JsonKey(name: 'workstatioN_CODE')
  final String workstationCode;
  @JsonKey(name: 'workorderbatchtypE_CODE')
  final String? workorderBatchTypeCode;
  @JsonKey(name: 'workorderbatchstatuS_CODE')
  final String? workorderBatchStatusCode;
  @JsonKey(name: 'codE_AGENCE')
  final String? codeAgence;
  @JsonKey(name: 'readingordeRs')
  List<ReadingOrder> readingOrders;

  WorkStationBatch({
    required this.workorderBatchCode,
    required this.theDate,
    required this.workstationCode,
    this.workorderBatchTypeCode,
    this.workorderBatchStatusCode,
    this.codeAgence,
    required this.readingOrders,
  });

  factory WorkStationBatch.fromJson(Map<String, dynamic> json) => _$WorkStationBatchFromJson(json);

  Map<String, dynamic> toJson() => _$WorkStationBatchToJson(this);

  factory WorkStationBatch.fromSqlite(Map<String, dynamic> json) {
    return WorkStationBatch(
      workorderBatchCode: json['workorderBatchCode'] as String? ?? '',
      theDate: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      workstationCode: json['workstationCode'] as String? ?? '',
      workorderBatchTypeCode: json['workorderBatchTypeCode'] as String? ?? '',
      workorderBatchStatusCode: json['workorderBatchStatusCode'] as String? ?? '',
      codeAgence: json['codeAgence'] as String? ?? '',
      readingOrders: json['readingOrders'] != null
          ? List<ReadingOrder>.from(jsonDecode(json['readingOrders']).map((x) => ReadingOrder.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toSqlite() {
    return {
      'workorderBatchCode': workorderBatchCode,
      'date': theDate.toIso8601String(),
      'workstationCode': workstationCode,
      'workorderBatchTypeCode': workorderBatchTypeCode ?? '',
      'workorderBatchStatusCode': workorderBatchStatusCode ?? '',
      'codeAgence': codeAgence ?? '',
      'readingOrders': jsonEncode(readingOrders.map((e) => e.toJson()).toList()), // Convert to JSON string
    };
  }
}
