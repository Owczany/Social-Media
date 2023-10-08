import 'package:flutter/material.dart';
import 'package:social_media/utils/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSettingsTap;
  final void Function()? onSingOut;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSettingsTap,
    required this.onSingOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              // home list tile
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.of(context).pop(),
              ),
              // profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
              MyListTile(
                icon: Icons.settings,
                text: 'S E T T I N G S',
                onTap: onSettingsTap,
              )
            ],
          ),
          // logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: onSingOut,
            ),
          )
        ],
      ),
    );
  }
}
