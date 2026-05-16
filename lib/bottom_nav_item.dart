import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavItem extends StatelessWidget {

  final IconData icon;
  final String label;
  final bool isActive;

  /// NEW
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,

    /// NEW
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final activeColor = const Color(0xFFE0B15A);
    final inactiveColor = const Color(0xFF8A796B);

    return GestureDetector(

      /// CHANGED
      onTap: onTap,

      behavior: HitTestBehavior.opaque,

      child: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          Container(

            width: 36,
            height: 36,

            decoration: BoxDecoration(

              color: isActive
                  ? activeColor.withOpacity(0.18)
                  : Colors.transparent,

              borderRadius: BorderRadius.circular(16),
            ),

            alignment: Alignment.center,

            child: Icon(

              icon,

              color: isActive
                  ? activeColor
                  : inactiveColor,

              size: 24,
            ),
          ),

          const SizedBox(height: 6),

          Text(

            label,

            style: GoogleFonts.inter(

              color: isActive
                  ? activeColor
                  : inactiveColor,

              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}