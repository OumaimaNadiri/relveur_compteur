import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar {
  static final List<CurvedNavigationBarItem> _navigationItems = [
     CurvedNavigationBarItem(
      child: Image.asset('assets/images/home_iconb.png', width: 30, height: 30),
    ),
     CurvedNavigationBarItem(
      child: Image.asset('assets/images/electric-meter.png', width: 30, height: 30),
    ), 
     CurvedNavigationBarItem(
      child: Image.asset('assets/images/switch.png', width: 30, height: 30),
    ),
     CurvedNavigationBarItem(
      child: Image.asset('assets/images/sync.png', width: 30, height: 30),
    ),
     CurvedNavigationBarItem(
      child: Image.asset('assets/images/business-report.png', width: 30, height: 30),
    ),
  ];

  CurvedNavigationBar buildNavigationBar({required Function(int) onTap}) {
    return CurvedNavigationBar(
      items: _navigationItems,
      onTap: onTap,
    );
  }
}
