import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Nouvelle page pour afficher la carte
class MapPage extends StatelessWidget {
  final LatLng position;

  const MapPage({Key? key, required this.position}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Position sur la carte'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('position'),
            position: position,
            infoWindow: InfoWindow(
              title: 'Position',
              snippet: 'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
            ),
          ),
        },
      ),
    );
  }
}