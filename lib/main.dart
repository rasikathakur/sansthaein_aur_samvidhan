import 'package:flutter/material.dart';
import 'package:sansthaein_samvidhan/LocaleString.dart';
import 'package:sansthaein_samvidhan/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:sansthaein_samvidhan/welcome_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: ProfilePage(),
  // ));
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
//   _MyAppState createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
  // Locale _locale = Locale('en');
  //
  // void setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en','US'),
      // locale: _locale,
      // supportedLocales: [
      //   Locale('en'),
      //   Locale('hi'),
      //   Locale('mr'),
      // ],
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      debugShowCheckedModeBanner: false,
      title: 'Sansthein Samvidhan',
      theme: ThemeData(
        primaryColor: Color(0xff426586),
        accentColor: Color(0xff648aae),
        scaffoldBackgroundColor: Color(0xfffafafa),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }


}