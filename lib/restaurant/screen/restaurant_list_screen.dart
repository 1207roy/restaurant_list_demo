import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:restaurantdemo/models/models.dart';
import 'package:restaurantdemo/resources/resources.dart' as resources;
import 'package:restaurantdemo/restaurant/repository/nearby_restaurants.dart'
    as nearby_restaurants;
import 'package:restaurantdemo/restaurant/widgets/restaurant_card_widget.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: <Widget>[
              searchBar,
              restaurantList,
            ],
          ),
        ),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: Text(
        'Trending Restaurant',
        style: TextStyle(color: Color(0xFF222455)),
      ),
      centerTitle: true,
      leading: InkWell(
        onTap: () {},
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget get restaurantList {
    return Expanded(
      child: ValueListenableBuilder<String>(
        valueListenable: _searchQueryNotifier,
        builder: (context, searchQuery, ___) {
          return FutureBuilder<List<Restaurant>>(
            future: _getRestaurants,
            builder: (context, AsyncSnapshot<List<Restaurant>> snapshot) {
              //progress UI
              if (snapshot.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());

              if (snapshot.data == null) return Container();

              final restaurants = snapshot.data.where((Restaurant restaurant) =>
                  restaurant.name
                      .toUpperCase()
                      .contains(searchQuery.toUpperCase()));

              return LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth ~/ 300;
                  Size size = MediaQuery.of(context).size;

                  double min = math.min(size.height, size.width);
                  double max = math.max(size.height, size.width);

                  return GridView.builder(
                    itemCount: restaurants.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (min / (max / 2.5)),
                        crossAxisCount:
                            crossAxisCount == 0 ? 1 : crossAxisCount),
                    itemBuilder: (context, index) {
                      final restaurant = restaurants.elementAt(index);

                      return RestaurantCardWidget(
                          restaurant: restaurant, onClick: () {});
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Restaurant>> get _getRestaurants async {
    List<Restaurant> nearByRestaurant = nearby_restaurants.restaurantList;
    return nearByRestaurant;
  }

  Widget get searchBar {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (searchQuery) => _searchQueryNotifier.value = searchQuery,
        decoration: searchBarDecoration,
      ),
    );
  }

  InputDecoration get searchBarDecoration {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(0),
      hintText: "Search",
      hintStyle: TextStyle(color: Color(0xFF8498BA)),
      prefixIcon: Icon(
        Icons.search,
//        color: Colors.blueGrey,
        color: Color(0xFFB6BED4),
      ),
      suffixIcon: settingsSearchBar,
      border: OutlineInputBorder(gapPadding: 0),
    );
  }

  Widget get settingsSearchBar {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          resources.ic_search_setting,
          height: 10,
//        color: Colors.blueGrey,
          color: Color(0xFFB6BED4),
        ),
      ),
      onTap: () {},
    );
  }
}
