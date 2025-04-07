import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String userRow;
  final String keyRow;
  final IconData iconData;

  const ProfileTile(
      {super.key, required this.userRow, required this.keyRow, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        keyRow,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        userRow,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class ProfileTileButton extends StatelessWidget {
  final String keyRow;
  final IconData iconData;
  final VoidCallback function;

  const ProfileTileButton(
      {super.key, required this.keyRow, required this.iconData, required this.function});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          keyRow,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(iconData),
        trailing: const Icon(Icons.navigate_next),
        onTap: function
    );
  }
}

class TileDivisor extends StatelessWidget {
  const TileDivisor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 16,
      endIndent: 16,
      height: 12,
    );
  }

}