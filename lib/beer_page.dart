import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'beer_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_bottom_nav.dart';
class BeersPage extends StatelessWidget {
  const BeersPage({super.key});

  @override
  Widget build(BuildContext context) {

    /// FIREBASE STREAM
    final beersStream = FirebaseFirestore.instance
        .collection('beers')
        .snapshots();

    return Scaffold(
      backgroundColor: const Color(0xFF140B06),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// TITLE

              Text(
                "Sörök",
              style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                        ),
              ),

              const SizedBox(height: 24),

              /// TABS

              Container(

                height: 54,

                decoration: BoxDecoration(
                  color: const Color(0xFF2A1B12),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(

                  children: [

                    /// ACTIVE TAB

                    Expanded(

                      child: Container(

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(18),

                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFD89B3C),
                              Color(0xFFB8741A),
                            ],
                          ),
                        ),

                        child: const Center(

                          child: Text(
                            "Csapolt sörök",

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// SECOND TAB

                    const Expanded(

                      child: Center(

                        child: Text(
                          "Üveges sörök",

                          style: TextStyle(
                            color: Color(0xFFB8A89A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// LIST

              Expanded(

                child: StreamBuilder<QuerySnapshot>(

                  stream: beersStream,

                  builder: (context, snapshot) {

                    /// LOADING
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    /// ERROR
                    if (snapshot.hasError) {

                      return Center(

                        child: Text(
                          'Hiba történt',

                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    /// DOCUMENTS
                    final beers = snapshot.data!.docs;

                    return ListView.separated(

                      itemCount: beers.length,

                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 16),

                      itemBuilder: (context, index) {

                        final beer =
                            beers[index].data()
                                as Map<String, dynamic>;

                        return BeerCard(

                          name: beer['name'],

                          abv: "${beer['abv']}% ABV",

                          price: "${beer['price']} Ft",

                          tag1: beer['tags'][0],

                          tag2: beer['tags'][1],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}