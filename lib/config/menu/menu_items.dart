import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Home',
    subtitle: 'Go to home screen',
    link: '/home',
    icon: Icons.home,
  ),
  MenuItem(
    title: 'Profile',
    subtitle: 'View your profile',
    link: '/profile',
    icon: Icons.person,
  ),
  MenuItem(
    title: 'Settings',
    subtitle: 'Adjust application settings',
    link: '/settings',
    icon: Icons.settings,
  ),
  MenuItem(
    title: 'Help',
    subtitle: 'Get help and support',
    link: '/help',
    icon: Icons.help,
  ),
];