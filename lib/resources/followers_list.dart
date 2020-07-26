import 'package:restaurantdemo/resources/resources.dart' as resources;

List<String> get _followersList => <String>[
      resources.ic_follower1,
      resources.ic_follower2,
      resources.ic_follower1,
      resources.ic_follower2,
    ];

int get maxNoOfFollowersIcon => _followersList.length;

List<String> getFollowersList(int noOfFollowers) {
  List<String> emptyDataList = [];
  if (noOfFollowers < maxNoOfFollowersIcon) {
    emptyDataList = List.filled(maxNoOfFollowersIcon - noOfFollowers, '');
  }

  return emptyDataList +
      _followersList.sublist(
          0,
          noOfFollowers > maxNoOfFollowersIcon
              ? maxNoOfFollowersIcon
              : noOfFollowers);
}
