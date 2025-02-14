import 'package:flutter/material.dart';

class ElectricMeter extends StatefulWidget {
  final double initialIndex;
  final ValueChanged<double>? onChanged;

  const ElectricMeter({
    Key? key,
    required this.initialIndex,
    this.onChanged,
  }) : super(key: key);

  @override
  _ElectricMeterState createState() => _ElectricMeterState();
}

class _ElectricMeterState extends State<ElectricMeter> {
  late double _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              _index -= 0.1; // Decrease the index by 0.1
              widget.onChanged?.call(_index);
            });
          },
        ),
        Text(
          _index.toStringAsFixed(1), // Display index with one decimal place
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _index += 0.1; // Increase the index by 0.1
              widget.onChanged?.call(_index);
            });
          },
        ),
      ],
    );
  }
}
