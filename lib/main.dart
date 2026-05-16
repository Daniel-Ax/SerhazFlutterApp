import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_bottom_nav.dart';
import 'beer_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'beer_page.dart';
import 'main_navigator.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      child: const MyApp(),
    ),
  );
}

/// 🔧 GLOBAL STATE (Provider)
class AppState extends ChangeNotifier {
  String _username = "Guest";

  String get username => _username;

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }
}

/// 🌍 ROOT APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RandomPage(),
        RandomPage.routeName: (context) => const RandomPage(),
        '/home': (context) => const MainNavigationPage(),
      },
    );
  }
}

/// 🔐 LOGIN / REGISTER PAGE
class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FlutterLogin(
          theme: LoginTheme(
            pageColorLight: Colors.transparent,
            pageColorDark: Colors.transparent,
            primaryColor: const Color.fromARGB(255, 250, 177, 60),
            accentColor: const Color.fromARGB(255, 82, 64, 6),
            errorColor: Colors.red,
            titleStyle: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 45,
              color:  Color.fromARGB(255, 82, 64, 6),
            ),
            bodyStyle: const TextStyle(fontFamily: 'NotoSans'),
            textFieldStyle: const TextStyle(fontFamily: 'OpenSans'),
            buttonStyle: const TextStyle(fontFamily: 'OpenSans'),
            cardTheme: const CardTheme(color: Color.fromARGB(210, 35, 20, 10)),
            inputTheme: const InputDecorationTheme(
              filled: true,
              fillColor:  Color.fromARGB(255, 94, 102, 141),
            ),
          ),
          onLogin: (LoginData data) async {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: data.name,
                password: data.password,
              );
              return null; // Success
            } on FirebaseAuthException catch (e) {
              return e.message ?? "Login failed";
            }
          },
          onSignup: (SignupData data) async {
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: data.name!,
                password: data.password!,
              );
              return null; // Success
            } on FirebaseAuthException catch (e) {
              return e.message ?? "Registration failed";
            }
          },
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          onRecoverPassword: (String email) async {
            // Implement password recovery if needed
            return null;
          },
        ),
      ),
    );
  }
}

/// 📊 Home SCREEN
class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = '/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> beersStream = FirebaseFirestore.instance
      .collection('beers')
      .snapshots();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Color.fromARGB(255, 146, 64, 14),
              Color.fromARGB(255, 139, 97, 74),
              Color.fromARGB(255, 65, 39, 17),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

              child: Column(
                children: [
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// LEFT SIDE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Üdv újra,",

                            style: GoogleFonts.inter(
                              color: const Color(0xFFB8A28C),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            user?.email ?? "Sörbarát!",

                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),

                      /// NOTIFICATION BUTTON
                      Container(
                        width: 42,
                        height: 42,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),

                        child: IconButton(
                          onPressed: () {},

                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFFE0B15A),
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        "Csapolt sörök",

                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      TextButton(
                        onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (context) => const BeersPage(),
                          ),
                        );
                      },

                        child: Text(
                          "Összes >",

                          style: GoogleFonts.inter(
                            color: const Color(0xFFE0B15A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 320,

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
                          return const Center(
                            child: Text(
                              'Hiba történt',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        /// DOCUMENTS
                        final beers = snapshot.data!.docs;

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          itemCount: beers.length,

                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 16),

                          itemBuilder: (context, index) {
                            final beer =
                                beers[index].data() as Map<String, dynamic>;

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
                  const SizedBox(height: 32),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Események",
                      style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                                  Row(
                    children: const [
                      Text(
                        
                        "Összes",
                        style: TextStyle(
                          color: Color(0xFFD89B3C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFFD89B3C),
                        size: 20,
                      ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color(0xFF2A1B12),
                      border: Border.all(
                        color: const Color(0xFF4A321F),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF4A321F),
                          ),
                          child: const Icon(
                            Icons.local_drink_rounded,
                            color: Color(0xFFE0B15A),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kvíz est a serházban",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "2024. július 15. - 19:00",
                              style: GoogleFonts.inter(
                                color: const Color(0xFFB8A28C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
              ],
              ),
            ),
          ]),
        ),
      ),
      ),
      ),
    );

  }
}
