import 'package:assabil/models/readingorder.dart';
import 'package:assabil/models/work_station_batch.dart';
import 'package:flutter/material.dart';

class WorkstationBatchDetailsScreen extends StatefulWidget {
  final WorkStationBatch workStationBatch;
  final List<ReadingOrder> readingOrders;

  WorkstationBatchDetailsScreen(this.workStationBatch, this.readingOrders);

  @override
  _WorkstationBatchDetailsScreenState createState() =>
      _WorkstationBatchDetailsScreenState();
}

class _WorkstationBatchDetailsScreenState
    extends State<WorkstationBatchDetailsScreen> {
  int itemsPerPage = 5;
  int currentPage = 0;
  PageController _pageController = PageController();

  Widget _buildPageGridView() {
    return Container(
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (widget.readingOrders.length / itemsPerPage).ceil(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentPage = index;
              });
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: index == currentPage
                    ? Colors.blue.shade900
                    : Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages =
        (widget.readingOrders.length / itemsPerPage).ceil(); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Orders for ${widget.workStationBatch.workorderBatchCode}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageGridView(), 
            Text(
              'Workstation Batch: ${widget.workStationBatch.workorderBatchCode}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: PageView.builder(
                itemCount: totalPages,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, pageIndex) {
                  final startIndex = pageIndex * itemsPerPage;
                  final endIndex = (pageIndex + 1) * itemsPerPage;
                  final pageOrders = widget.readingOrders.sublist(
                      startIndex,
                      endIndex <
                              widget
                                  .readingOrders.length 
                          ? endIndex
                          : widget.readingOrders.length);

                  return ListView.builder(
                    itemCount: pageOrders.length,
                    itemBuilder: (context, index) {
                      final readingOrder = pageOrders[index];
                      return GestureDetector(
                        onTap: () {
                          
                        },
                        child: Card(
                          elevation: 4.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(Icons.electrical_services, color: Colors.blue),
                            title: Text('Reading Order: ${readingOrder.readingorderCode  }'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Previous Index: ${readingOrder.previousindex ?? ''}'),
                                Text('Previous Index Date: ${readingOrder.previousindexdate ?? ''}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
