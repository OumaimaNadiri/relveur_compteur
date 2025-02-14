import 'dart:async';
import 'dart:io';
import 'package:assabil/models/orderdetail.dart';
import 'package:assabil/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:assabil/components/drawer.dart';
import 'package:assabil/components/notification_icon.dart';
import 'package:assabil/models/readingorder.dart';
import 'package:assabil/provider/ordreProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class OrderDetailPage extends StatefulWidget {
  final String orderId;

  OrderDetailPage({required this.orderId});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  String? _selectedNotice;
  String? _imagePath;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadOrderDetails();
  }

  void _loadOrderDetails() {
    final orderDetailModel = context.read<OrderDetailModel>();
    final orderDetail = orderDetailModel.getOrderDetail(widget.orderId);

    if (orderDetail != null) {
      _indexController.text = orderDetail.index?.toString() ?? '';
      _numeroController.text = orderDetail.number ?? '';
      _selectedNotice = orderDetail.notice;
      _imagePath = orderDetail.imagePath;
      _currentPosition = Position(
        latitude: orderDetail.latitude ?? 0,
        longitude: orderDetail.longitude ?? 0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Détails de l\'ordre',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          NotificationIcon(
              onItemSelected: (value) => print('Selected: $value')),
        ],
      ),
      drawer: MyDrawer(),
      body: Consumer<OrderDetailModel>(
        builder: (context, orderDetailModel, child) {
          final order = orderDetailModel.currentOrder;
          if (order == null) {
            return Center(child: Text('Aucun ordre sélectionné'));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildOrderDetailsHeader(order),
                        const SizedBox(height: 30),
                        _buildIndexInput(),
                        const SizedBox(height: 20),
                        _buildNoticeRow(),
                        const SizedBox(height: 10),
                        _buildNumeroInput(),
                        const SizedBox(height: 20),
                        _buildImagePicker(),
                        const SizedBox(height: 20),
                        _buildTabView(order),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveOrderDetails,
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildPositionInfo(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderDetailsHeader(ReadingOrder order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'UDR: ${order.itineraryCode}',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Text(
            'Sequence: ${order.sequence?.toInt() ?? 'N/A'}',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }

Widget _buildIndexInput() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5, // Change to 5 cases
        (index) => Row(
          children: [
            Container(
              width: 40,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: index == 4 ? Colors.grey : Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: index == 0 ? _indexController : null,
                textAlign: TextAlign.center,
                maxLength: 1,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24, color: index == 4 ? Colors.red : Colors.white),
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                  hintText: '0',
                  hintStyle: TextStyle(fontSize: 24, color: index == 4 ? Colors.red : Colors.white),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                onTap: () {
                  if (_indexController.text.length == index) {
                    _indexController.clear();
                  }
                },
              ),
            ),
            index < 4 ? SizedBox(width: 10) : SizedBox(), // Adjust spacing for 5 cases
          ],
        ),
      ),
    ),
  );
}




  Widget _buildNoticeRow() {
    return Row(
      children: [
        Text('Notice : ', style: TextStyle(fontWeight: FontWeight.bold)),
        if (_selectedNotice != null)
          Expanded(
            child: Text(
              _selectedNotice!,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _showNoticeSelectionDialog(context),
        ),
      ],
    );
  }

 Widget _buildNumeroInput() {
  return TextField(
    controller: _numeroController,
    style: TextStyle(color: _numeroController.text.isEmpty ? Colors.red : Colors.green),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: 'Saisir le numéro',
      labelStyle: TextStyle(color: _numeroController.text.isEmpty ? Colors.red : Colors.green),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0), // Bordures ovales
        borderSide: BorderSide(color: _numeroController.text.isEmpty ? Colors.red : Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: _numeroController.text.isEmpty ? Colors.red : Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: Colors.green),
      ),
      prefixIcon: Icon(Icons.phone),
    ),
    onChanged: (value) {
      setState(() {}); // Pour mettre à jour le style lorsque le texte change
    },
  );
}


 Widget _buildImagePicker() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center, // Aligning children to the center
        children: [
          TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera_alt),
            label: Text(''),
          ),
          SizedBox(width: 10), // Adding space between the icon and the image
          if (_imagePath != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(),
                      body: Center(
                        child: Image.file(
                          File(_imagePath!),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Image.file(
                File(_imagePath!),
                height: 50, // Small image size
              ),
            ),
        ],
      ),
      if (_imagePath != null) SizedBox(height: 10),
      if (_imagePath != null)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: Image.file(
                      File(_imagePath!),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    ],
  );
}



  Widget _buildTabView(ReadingOrder order) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 5),
                    VerticalDivider(),
                    Text('Client'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.device_hub),
                    SizedBox(width: 5),
                    VerticalDivider(),
                    Text('Compteur'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              children: [
                _buildClientInfoView(order),
                _buildMeterInfoView(order),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfoView(ReadingOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(
          icon: Icons.person,
          title: 'Nom de client',
          subtitle: order.name ?? 'N/A',
        ),
        _buildInfoCard(
          icon: Icons.person_pin_circle,
          title: 'Adresse de client',
          subtitle: '${order.streetname2 ?? ''} ${order.streetname2 ?? ''}',
        ),
        _buildInfoCard(
          icon: Icons.contacts,
          title: 'Numéro de contrat',
          subtitle: order.contractCode ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildMeterInfoView(ReadingOrder order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(
          icon: Icons.device_hub,
          title: 'Numéro de compteur',
          subtitle: order.zwnummer ?? 'N/A',
        ),
        _buildInfoCard(
          icon: Icons.settings_input_component,
          title: 'Type de compteur',
          subtitle: order.zzwtyp ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildPositionInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_currentPosition != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapPage(
                position: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
              ),
            ),
          );
        }
      },
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_currentPosition?.latitude ?? "N/A"}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 50),
            Text(
              'Longitude: ${_currentPosition?.longitude ?? "N/A"}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

 

  Future<void> _showNoticeSelectionDialog(BuildContext context) async {
    final List<String> noticeOptions = ['Notice 1', 'Notice 2', 'Notice 3'];

    String? selectedNotice = await showDialog(
      context: context,
      builder: (context) {
        String? selectedValue;
        return AlertDialog(
          title: Text('Sélectionner une notice'),
          content: DropdownButton<String>(
            items: noticeOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              selectedValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, selectedValue),
              child: Text('Valider'),
            ),
          ],
        );
      },
    );

    if (selectedNotice != null) {
      setState(() {
        _selectedNotice = selectedNotice;
      });
    }
  }

 
 Future<void> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'Les services de localisation sont désactivés.';
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Les permissions de localisation sont refusées.';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'Les permissions de localisation sont définitivement refusées.';
  }

  _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  if (mounted) {
    setState(() {
      // Mettre à jour l'état uniquement si le widget est toujours monté
    });
  }
}

  void _saveOrderDetails() {
    final orderDetailModel = context.read<OrderDetailModel>();
    final orderDetail = OrderDetail(
      orderId: widget.orderId,
      index: double.tryParse(_indexController.text),
      number: _numeroController.text,
      notice: _selectedNotice,
      imagePath: _imagePath,
      latitude: _currentPosition?.latitude,
      longitude: _currentPosition?.longitude,
    );

    orderDetailModel.setOrderDetail(orderDetail);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order details saved!'),
      ),
    );
  }
}
