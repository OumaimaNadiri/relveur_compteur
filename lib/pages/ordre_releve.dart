import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assabil/provider/ordreProvider.dart';
import 'package:assabil/sqlite/data_acces.dart';
import 'package:assabil/models/readingorder.dart';
import 'package:assabil/components/drawer.dart';
import 'ordre_detail_page.dart';

class ReleveurScreen extends StatefulWidget {
  @override
  _ReleveurScreenState createState() => _ReleveurScreenState();
}

class _ReleveurScreenState extends State<ReleveurScreen> {
  final SQLRequest _dataHandler = SQLRequest();
  List<ReadingOrder> orders = [];
  List<ReadingOrder> filteredOrders = [];
  int itemsPerPage = 6;
  int currentPage = 0;
  PageController _pageController = PageController();
  TextEditingController _searchController = TextEditingController();
  String _sortOption = 'Nom';

  @override
  void initState() {
    super.initState();
    _loadOrders();
    _searchController.addListener(_filterOrders);
  }

  Future<void> _loadOrders() async {
    List<ReadingOrder> orders = await _dataHandler.getReadingOrders();
    setState(() {
      this.orders = orders;
      this.filteredOrders = orders;
    });
  }

  void _filterOrders() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredOrders = orders.where((order) {
        final name = order.name?.toLowerCase() ?? '';
        final code = order.readingorderCode.toLowerCase() ;
        return name.contains(query) || code.contains(query);
      }).toList();
      _sortOrders();
    });
  }

  void _sortOrders() {
    if (_sortOption == 'Nom') {
      filteredOrders.sort((a, b) {
        final nameA = a.name ?? '';
        final nameB = b.name ?? '';
        return nameA.compareTo(nameB);
      });
    } else if (_sortOption == 'Code') {
      filteredOrders.sort((a, b) {
        final codeA = a.readingorderCode ;
        final codeB = b.readingorderCode ;
        return codeA.compareTo(codeB);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(context),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            _buildSearchBar(),
            SizedBox(height: 16.0),
            _buildSortOptions(),
            SizedBox(height: 16.0),
            _buildPageIndicator(),
            SizedBox(height: 16.0),
            Expanded(
              child: PageView.builder(
                itemCount: (filteredOrders.length / itemsPerPage).ceil(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, pageIndex) {
                  return _buildOrderPage(pageIndex);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade900,
      title: Text('Ordres de relevés', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Selected: $value');
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'item1',
              child: Text('Item 1'),
            ),
            PopupMenuItem<String>(
              value: 'item2',
              child: Text('Item 2'),
            ),
          ],
          icon: Icon(Icons.notifications, color: Colors.white),
        ),
      ],
      bottom: PreferredSize(
        child: Container(
          color: Colors.white,
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(2.0),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Rechercher par nom ou code',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildSortOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Trier par:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: _sortOption,
          items: [
            DropdownMenuItem(
              child: Text('Nom'),
              value: 'Nom',
            ),
            DropdownMenuItem(
              child: Text('Code'),
              value: 'Code',
            ),
          ],
          onChanged: (value) {
            setState(() {
              _sortOption = value!;
              _sortOrders();
            });
          },
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (filteredOrders.length / itemsPerPage).ceil(),
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

  Widget _buildOrderPage(int pageIndex) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: itemsPerPage,
            itemBuilder: (context, index) {
              int orderIndex = pageIndex * itemsPerPage + index;
              if (orderIndex < filteredOrders.length) {
                return _buildOrderItem(orderIndex);
              }
              return SizedBox.shrink();
            },
          ),
        ),
        SizedBox(height: 16.0),
       
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildOrderItem(int orderIndex) {
    return InkWell(
      onTap: () {
        Provider.of<OrderDetailModel>(context, listen: false)
            .setCurrentOrder(filteredOrders[orderIndex]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(
                orderId: filteredOrders[orderIndex].readingorderCode), // Utiliser orderId à la place de id
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.orange,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client: ${filteredOrders[orderIndex].name}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Ville: ${filteredOrders[orderIndex].city}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
               SizedBox(height: 8.0),
              Text(
                'Sequence: ${filteredOrders[orderIndex].sequence?.toInt() ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              Text(
                ' ${filteredOrders[orderIndex].readingorderCode}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ],
          ),
          trailing: _buildOrderImage(
              filteredOrders[orderIndex].newIndex?.toInt() ?? 0),
        ),
      ),
    );
  }

  Widget _buildOrderImage(int newIndex) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/electric_counter.webp',
          width: 50,
          height: 50,
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.blue.shade700,
            child: Text(
              '$newIndex',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
