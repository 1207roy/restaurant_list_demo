import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurantdemo/resources/resources.dart' as resources;

class FollowersWidget extends StatelessWidget {
  final int noOfFollowers;
  final List<String> followersAssetList;

  FollowersWidget({Key key, this.noOfFollowers})
      : followersAssetList = resources.getFollowersList(noOfFollowers),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double layoutWidth = constraints.maxWidth;
        return Stack(
          children: followersAssetList.reversed
              .toList()
              .asMap()
              .map((index, assetPath) => MapEntry(
                  index,
                  TransformedIcons(
                    index: index,
                    assetPath: assetPath,
                    noOfFollowers: noOfFollowers,
                    layoutWidth: layoutWidth,
                  )))
              .values
              .toList(),
        );
      },
    );
  }
}

class TransformedIcons extends StatelessWidget {
  String assetPath;
  int noOfFollowers;
  int index;
  int maxNoOfFollowersIcon = resources.maxNoOfFollowersIcon;
  double layoutWidth;
  double shiftPercentage = 30;

  bool get isFirstDrawnLastCard => index == 0;

  bool get moreThan4Followers => noOfFollowers > maxNoOfFollowersIcon;

  TransformedIcons(
      {Key key,
      this.index,
      this.assetPath,
      this.noOfFollowers,
      this.layoutWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconWidth = layoutWidth /
        (maxNoOfFollowersIcon -
            ((maxNoOfFollowersIcon - 1) * (shiftPercentage / 100)));
    double xShifting = (maxNoOfFollowersIcon - 1 - index) *
        (iconWidth * ((100 - shiftPercentage) / 100));

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          xShifting,
          0.0,
          0.0,
        ),
      child: _buildIconCard(iconWidth),
    );
  }

  Widget _buildIconCard(double iconWidth) {
    if (assetPath?.isEmpty != false) return Container();

    bool isTextWidgetToBeAdded = isFirstDrawnLastCard && moreThan4Followers;

    return CircleAvatar(
      radius: iconWidth / 2,
      backgroundImage: AssetImage(assetPath),
      backgroundColor: Colors.transparent,
      child: isTextWidgetToBeAdded
          ? Center(
              child: Container(
                width: iconWidth / 2.5,
                child: FittedBox(
                  child: Text(
                    '+${noOfFollowers - maxNoOfFollowersIcon}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
