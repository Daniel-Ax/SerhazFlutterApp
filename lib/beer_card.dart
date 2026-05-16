import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeerCard extends StatelessWidget {

  final String name;
  final String abv;
  final String price;
  final String tag1;
  final String tag2;

  const BeerCard({
    super.key,
    required this.name,
    required this.abv,
    required this.price,
    required this.tag1,
    required this.tag2,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 170,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(24),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3A2617),
            Color(0xFF22140D),
          ],
        ),

        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// IMAGE PLACEHOLDER
          Container(

            height: 130,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: const Color(0xFF5A3A24),
            ),

            child: const Center(
              child: Icon(
                Icons.local_bar,
                color: Color(0xFFE0B15A),
                size: 42,
              ),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            name,

            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: GoogleFonts.oswald(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            abv,

            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.65),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              _BeerTag(label: tag1),

              const SizedBox(width: 8),

              _BeerTag(label: tag2),
            ],
          ),

          const SizedBox(height: 16),

          RichText(

            text: TextSpan(

              children: [

                TextSpan(
                  text: price,

                  style: GoogleFonts.oswald(
                    color: const Color(0xFFE0B15A),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                TextSpan(
                  text: " / 0,5l",

                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BeerTag extends StatelessWidget {

  final String label;

  const _BeerTag({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF4A311F),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(

        label,

        style: GoogleFonts.inter(
          color: const Color(0xFFE0B15A),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}