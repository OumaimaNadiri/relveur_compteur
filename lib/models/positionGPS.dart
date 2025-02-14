class PositionGps {
  
  final String number;
  final String imagePath;
  final double latitude;
  final double longitude;

  PositionGps({
    required this.number,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}


  
  

