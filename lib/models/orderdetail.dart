class OrderDetail {
  final String orderId;
  double? index;
  String? number;
  String? notice;
  String? imagePath;
  double? latitude;
  double? longitude;

  OrderDetail({
    required this.orderId,
    this.index,
    this.number,
    this.notice,
    this.imagePath,
    this.latitude,
    this.longitude,
  });
}
