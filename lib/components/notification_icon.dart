import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final void Function(String) onItemSelected;

  const NotificationIcon({Key? key, required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onItemSelected,
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
    );
  }
}
