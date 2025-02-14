// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_station_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkStationBatch _$WorkStationBatchFromJson(Map<String, dynamic> json) =>
    WorkStationBatch(
      workorderBatchCode: json['workorderbatcH_CODE'] as String,
      theDate: DateTime.parse(json['thedate'] as String),
      workstationCode: json['workstatioN_CODE'] as String,
      workorderBatchTypeCode: json['workorderbatchtypE_CODE'] as String? ?? '',
      workorderBatchStatusCode:
          json['workorderbatchstatuS_CODE'] as String? ?? '',
      codeAgence: json['codE_AGENCE'] as String? ?? '',
      readingOrders: (json['readingordeRs'] as List<dynamic>?)
              ?.map((e) => ReadingOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$WorkStationBatchToJson(WorkStationBatch instance) =>
    <String, dynamic>{
      'workorderbatcH_CODE': instance.workorderBatchCode,
      'thedate': instance.theDate.toIso8601String(),
      'workstatioN_CODE': instance.workstationCode,
      'workorderbatchtypE_CODE': instance.workorderBatchTypeCode,
      'workorderbatchstatuS_CODE': instance.workorderBatchStatusCode,
      'codE_AGENCE': instance.codeAgence,
      'readingordeRs': instance.readingOrders,
    };
