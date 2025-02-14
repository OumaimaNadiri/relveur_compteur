import 'package:assabil/models/readingorder.dart';
import 'package:flutter/material.dart';
import 'package:assabil/models/work_station_batch.dart';
import 'package:assabil/services/api.dart'; // Importez votre service API
import 'package:assabil/pages/reading_order_list.dart';

class WorkstationBatchScreen extends StatefulWidget {
  @override
  _WorkstationBatchScreenState createState() => _WorkstationBatchScreenState();
}

class _WorkstationBatchScreenState extends State<WorkstationBatchScreen> {
  List<WorkStationBatch> _workstationBatchList = [];

  @override
  void initState() {
    super.initState();
    // Remplacez 'workOrderBatchCode' par le code réel du workOrderBatch
    _fetchWorkstationBatchData('workOrderBatchCode');
  }

  Future<void> _fetchWorkstationBatchData(String workOrderBatchCode) async {
    try {
      // Récupérez les données du workOrderBatch
      List<WorkStationBatch> data = await getWorkStationBatch(workOrderBatchCode);

      setState(() {
        _workstationBatchList = data;
      });
    } catch (e) {
      print('Error fetching workstation batch data: $e');
    }
  }

  void _navigateToReadingOrders(WorkStationBatch workStationBatch, List<ReadingOrder> readingOrders) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkstationBatchDetailsScreen(workStationBatch, readingOrders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workstation Batch Data'),
      ),
      body: _workstationBatchList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _workstationBatchList.length,
              itemBuilder: (context, index) {
                final workstationBatch = _workstationBatchList[index];
                return InkWell(
                  onTap: () async {
                    // Récupérez les données des reading orders pour le workOrderBatch sélectionné
                    List<ReadingOrder> readingOrders = await getWorkOrderBatchReadingOrders(workstationBatch.workorderBatchCode);
                    _navigateToReadingOrders(workstationBatch, readingOrders);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(workstationBatch.workorderBatchCode),
                      subtitle: Text(workstationBatch.theDate.toString()),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

