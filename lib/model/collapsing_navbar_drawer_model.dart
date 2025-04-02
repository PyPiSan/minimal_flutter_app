import 'package:flutter/material.dart';

class CollapsingNavbarDrawerModel {
  String title;
  IconData icon;
  CollapsingNavbarDrawerModel({required this.title, required this.icon});
}

List<CollapsingNavbarDrawerModel> navigationItems = [
  CollapsingNavbarDrawerModel(title: 'Home', icon: Icons.home),
  CollapsingNavbarDrawerModel(title: 'Anime', icon: Icons.business),
  CollapsingNavbarDrawerModel(title: 'Drama', icon: Icons.school),
  CollapsingNavbarDrawerModel(title: 'Settings', icon: Icons.settings),
];
