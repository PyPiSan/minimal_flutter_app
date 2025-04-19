import 'package:flutter/material.dart';

class CollapsingNavbarDrawerModel {
  String title;
  IconData icon;
  CollapsingNavbarDrawerModel({required this.title, required this.icon});
}

List<CollapsingNavbarDrawerModel> navigationItems = [
  CollapsingNavbarDrawerModel(title: 'Chat', icon: Icons.message),
  CollapsingNavbarDrawerModel(title: 'Portfolio', icon: Icons.business),
  CollapsingNavbarDrawerModel(title: 'History', icon: Icons.history),
];
