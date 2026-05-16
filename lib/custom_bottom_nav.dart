import 'package:flutter/material.dart';

import 'bottom_nav_item.dart';

class CustomBottomNav extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF1A120B).withOpacity(0.95),

        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          BottomNavItem(
            icon: Icons.home_rounded,
            label: "Főoldal",

            isActive: currentIndex == 0,

            onTap: () => onTap(0),
          ),

          BottomNavItem(
            icon: Icons.local_bar_outlined,
            label: "Sörök",

            isActive: currentIndex == 1,

            onTap: () => onTap(1),
          ),

          BottomNavItem(
            icon: Icons.calendar_today_outlined,
            label: "Események",

            isActive: currentIndex == 2,

            onTap: () => onTap(2),
          ),

          BottomNavItem(
            icon: Icons.groups_outlined,
            label: "Törzsvendég",

            isActive: currentIndex == 3,

            onTap: () => onTap(3),
          ),

          BottomNavItem(
            icon: Icons.person_outline_rounded,
            label: "Profil",

            isActive: currentIndex == 4,

            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}