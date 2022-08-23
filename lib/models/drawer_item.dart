import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;

 final String label;
  final Function() onTap;

  const DrawerItem(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}