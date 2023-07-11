import 'package:flutter/material.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double containerHeight;
  SliverDelegate({@required this.child, @required this.containerHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => containerHeight;

  @override
  double get minExtent => containerHeight;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != containerHeight || oldDelegate.minExtent != containerHeight || child != oldDelegate.child;
  }
}