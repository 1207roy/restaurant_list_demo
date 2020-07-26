import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurantdemo/models/models.dart';
import 'package:restaurantdemo/resources/resources.dart' as resources;
import 'package:restaurantdemo/restaurant/widgets/widgets.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onClick;

  const RestaurantCardWidget({
    Key key,
    this.restaurant,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onClick,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _restaurantImageWidget,
            ),
            _restaurantMetaData,
          ],
        ),
      ),
    );
  }

  Widget get _restaurantImageWidget {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(restaurant.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(),
        ),
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[_statusWidget, _ratingWidget],
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  //without using image
  Widget get _statusWidget {
    double height = 25.0;
    double width = 60.0;

    return Padding(
      padding: EdgeInsets.all(height / 2),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(height / 5)),
        ),
        child: Center(
          child: Text(
            '${restaurant.restaurantStatus.status}',
            style: TextStyle(
                color: restaurant.restaurantStatus.statusColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //without using image
  Widget get _ratingWidget {
    double height = 25.0;
    double width = 60.0;

    return Padding(
      padding: EdgeInsets.all(height / 2),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(height / 5)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(height: height / 2, image: AssetImage(resources.ic_star)),
//              Text(' '),
              Text(restaurant.rating?.toString() ?? '')
            ],
          ),
        ),
      ),
    );
  }

  Widget get _restaurantMetaData {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _restaurantTitleWidget,
                  Text(' '),
                  _restaurantAddressWidget
                ],
              ),
              flex: 6,
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
                child: FollowersWidget(noOfFollowers: restaurant.noOfFollowers),
                flex: 3)
          ],
        ),
      ),
    );
  }

  //without using image
  Widget get _restaurantTitleWidget => Row(
        children: <Widget>[
          Expanded(
            child: _restaurantNameWidget,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: restaurant.restaurantType.colorList)),
              //#FFB289, #FF92A2
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  '${restaurant.restaurantType.name}',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xFF848DFF)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  '${restaurant.distance ?? ''}',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      );

  Widget get _restaurantNameWidget {
    return FittedBox(
      child: Text('${restaurant.name}',
          style:
              TextStyle(color: Color(0xFF3E3F68), fontWeight: FontWeight.bold)),
    );
  }

  Widget get _restaurantAddressWidget {
    return FittedBox(
      child: Text('${restaurant.address?.wholeAddress ?? ''}',
          style: TextStyle(
            color: Color(0xFF8498BA),
          )),
    );
  }
}
