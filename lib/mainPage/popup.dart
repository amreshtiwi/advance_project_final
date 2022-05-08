// import 'package:covid_project/signIn.dart';
// import 'package:covid_project/signup.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../map/mapPage.dart';

List<PopupMenuEntry<MenuItem>> list = [];

class popup extends StatefulWidget {
  @override
  State<popup> createState() => _poubState();
}

class _poubState extends State<popup> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) {
        list = [
          ...menuItems.itemsFirst.map(buildItem).toList(),
          PopupMenuDivider(),
          ...menuItems.itemsSecond.map(buildItem).toList()
        ];

        return list;
      },
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: Row(children: [
        Icon(item.icon, color: Colors.black, size: 20),
        const SizedBox(width: 12),
        Text(item.text, style: TextStyle(fontWeight: FontWeight.w500)),
      ]));

  onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case menuItems.maps:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => map(
                    title: 'map',
                  )), //////////////////////////////////////
        );
        break;

      case menuItems.signOut:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  wellcomsecreen()), //////////////////////////////////////
        );
        break;
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class menuItems {
  static const List<MenuItem> itemsFirst = [
    maps,
  ];

  static const List<MenuItem> itemsSecond = [signOut];
  static const maps = MenuItem(text: 'Map', icon: Icons.map_outlined);

  static const signOut =
      MenuItem(text: 'Sign Out', icon: Icons.logout_outlined);
}
