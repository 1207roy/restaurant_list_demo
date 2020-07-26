import 'package:flutter/material.dart';
import 'package:restaurantdemo/resources/resources.dart' as resources;

import 'restaurant/screen/restaurant_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Demo',
      theme: resources.appTheme,
      home: RestaurantListScreen(),
    );
  }
}
