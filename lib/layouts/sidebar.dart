import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  late final int selectedIndex;
  final NavigationRailLabelType labelType;
  final bool showLeading;
  final bool showTrailing;
  final double groupAlignment;

  SideBar({
    this.selectedIndex = 0,
    this.labelType = NavigationRailLabelType.none,
    this.showLeading = false,
    this.showTrailing = false,
    this.groupAlignment = -1.0,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      groupAlignment: widget.groupAlignment,
      onDestinationSelected: (int index) {
        setState(() {
          widget.selectedIndex = index;
        });
      },
      labelType: widget.labelType,
      leading: widget.showLeading
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
      trailing: widget.showTrailing
          ? IconButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.more_horiz_rounded),
            )
          : const SizedBox(),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('Third'),
        ),
      ],
    );
  }
}
