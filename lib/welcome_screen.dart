// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:crypto/crypto.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
// import 'profile_page.dart';
//
// class AuthWrapper extends StatelessWidget {
//   final storage = FlutterSecureStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.hasData) {
//             return ProfilePage();
//           } else {
//             return WelcomeScreen();
//           }
//         }
//         return Scaffold(
//           backgroundColor: Color(0xfffafafa),
//           body: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
//
// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffffffff),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/wecome.jpg',
//               height: 280,
//               width: 600,
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Welcome to\nSansthein Samvidhan',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff426586),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Learn and explore the constitution in an interactive way',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color(0xff648aae),
//               ),
//             ),
//             SizedBox(height: 60),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/register'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xff426586),
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Create Account',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/login'),
//                 style: OutlinedButton.styleFrom(
//                   primary: Color(0xff426586),
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   side: BorderSide(color: Color(0xff426586)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final _storage = FlutterSecureStorage();
//   final _googleSignIn = GoogleSignIn();
//
//   String _email = '';
//   String _username = '';
//   String _password = '';
//   String _confirmPassword = '';
//   bool _isLoading = false;
//
//   String _hashPassword(String password) {
//     var bytes = utf8.encode(password);
//     var digest = sha256.convert(bytes);
//     return digest.toString();
//   }
//
//   Future<void> _registerWithEmail() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _email,
//         password: _password,
//       );
//
//       final hashedPassword = _hashPassword(_password);
//       await _storage.write(key: 'password', value: hashedPassword);
//
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': _email,
//         'username': _username,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       Navigator.pushReplacementNamed(context, '/profile');
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'Registration failed')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   Future<void> _registerWithGoogle() async {
//     try {
//       // Step 1: Sign in with Google
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return;
//
//       // Step 2: Get authentication details
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Step 3: Create Firebase credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Step 4: Sign in to Firebase with Google credentials
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       // Step 5: Save user data to Firestore
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': userCredential.user!.email,
//         'username': userCredential.user!.displayName ?? 'Google User',
//         'createdAt': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//
//       Navigator.pushReplacementNamed(context, '/profile');
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       appBar: AppBar(
//         title: Text('Create Account'),
//         backgroundColor: Color(0xff426586),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => _email = value,
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a username';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => _username = value,
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => _password = value,
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                   prefixIcon: Icon(Icons.lock),
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value != _password) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) => _confirmPassword = value,
//               ),
//               SizedBox(height: 30),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _registerWithEmail,
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xff426586),
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Divider(thickness: 1, color: Color(0xff648aae)),
//               SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton.icon(
//                   onPressed: _registerWithGoogle,
//                   style: OutlinedButton.styleFrom(
//                     primary: Color(0xff426586),
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     side: BorderSide(color: Color(0xff426586)),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   icon: Image.asset('assets/google.png', height: 24),
//                   label: Text('Sign up with Google'),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextButton(
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
//                 child: Text(
//                   'Already have an account? Sign In',
//                   style: TextStyle(color: Color(0xff426586)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _storage = FlutterSecureStorage();
//   final _formKey = GlobalKey<FormState>();
//   final _googleSignIn = GoogleSignIn();
//
//   String _email = '';
//   String _password = '';
//   bool _isLoading = false;
//
//   String _hashPassword(String password) {
//     var bytes = utf8.encode(password);
//     var digest = sha256.convert(bytes);
//     return digest.toString();
//   }
//
//   Future<void> _loginWithEmail() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: _email,
//         password: _password,
//       );
//
//       final hashedPassword = _hashPassword(_password);
//       await _storage.write(key: 'password', value: hashedPassword);
//
//       Navigator.pushReplacementNamed(context, '/profile');
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'Login failed')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     Navigator.pushReplacementNamed(context, '/profile');
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//
//   }
//
//   // Future<void> _signInWithGoogle() async {
//   //   try {
//   //     // Step 1: Sign in with Google
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//   //     if (googleUser == null) return;
//   //
//   //     // Step 2: Get authentication details
//   //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//   //
//   //     // Step 3: Create Firebase credential
//   //     final AuthCredential credential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );
//   //
//   //     // Step 4: Sign in to Firebase with Google credentials
//   //     await _auth.signInWithCredential(credential);
//   //
//   //     Navigator.pushReplacementNamed(context, '/profile');
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       appBar: AppBar(
//         title: Text('Sign In'),
//         backgroundColor: Color(0xff426586),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: Icon(Icons.email),
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => _email = value,
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       prefixIcon: Icon(Icons.lock),
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => _password = value,
//                   ),
//                   SizedBox(height: 20),
//                   _isLoading
//                       ? CircularProgressIndicator()
//                       : SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _loginWithEmail,
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xff426586),
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         'Sign In',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Divider(thickness: 1, color: Color(0xff648aae)),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: OutlinedButton.icon(
//                       onPressed: signInWithGoogle,
//                       style: OutlinedButton.styleFrom(
//                         primary: Color(0xff426586),
//                         padding: EdgeInsets.symmetric(vertical: 15),
//                         side: BorderSide(color: Color(0xff426586)),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       icon: Image.asset('assets/google.png', height: 24),
//                       label: Text('Sign in with Google'),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
//                     child: Text(
//                       'Don\'t have an account? Sign Up',
//                       style: TextStyle(color: Color(0xff426586)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'profile_page.dart';

class AuthWrapper extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ProfilePage();
          } else {
            return WelcomeScreen();
          }
        }
        return Scaffold(
          backgroundColor: Color(0xfffafafa),
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffffff),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/wecome.jpg',
              height: 280,
              width: 600,
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to\nSansthein Samvidhan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xff426586),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Learn and explore the constitution in an interactive way',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff648aae),
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff426586),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                style: OutlinedButton.styleFrom(
                  primary: Color(0xff426586),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  side: BorderSide(color: Color(0xff426586)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FlutterSecureStorage();
  final _googleSignIn = GoogleSignIn();

  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<int> _getNextActivityId() async {
    final querySnapshot = await _firestore.collection('user_activity').orderBy('activity_id', descending: true).limit(1).get();
    if (querySnapshot.docs.isEmpty) {
      return 1;
    } else {
      return querySnapshot.docs.first.get('activity_id') + 1;
    }
  }

  Future<void> _createUserActivity(String userId) async {
    final nextActivityId = await _getNextActivityId();

    await _firestore.collection('user_activity').doc(userId).set({
      'activity_id': nextActivityId,
      'e_count': 0,
      'l_count': 0,
      'j_count': 0,
      'game_1_level_count': 0,
      'game_2_level': 'null',
      'game_3_level': 'null',
      'user_id': userId,
    });
  }

  Future<String> _getNextGoogleUsername() async {
    final querySnapshot = await _firestore.collection('users')
        .where('username', isGreaterThanOrEqualTo: 'GoogleUser')
        .where('username', isLessThan: 'GoogleUserz')
        .orderBy('username', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 'GoogleUser1';
    } else {
      final lastUsername = querySnapshot.docs.first.get('username');
      final number = int.tryParse(lastUsername.replaceAll('GoogleUser', '')) ?? 0;
      return 'GoogleUser${number + 1}';
    }
  }

  Future<void> _registerWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      final hashedPassword = _hashPassword(_password);
      await _storage.write(key: 'password', value: hashedPassword);

      // Save user data
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _email,
        'username': _username,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create user activity
      await _createUserActivity(userCredential.user!.uid);

      Navigator.pushReplacementNamed(context, '/profile');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      // Step 2: Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Step 3: Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in to Firebase with Google credentials
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Generate default username
      final googleUsername = await _getNextGoogleUsername();

      // Step 5: Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'username': googleUsername,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Create user activity
      await _createUserActivity(userCredential.user!.uid);

      Navigator.pushReplacementNamed(context, '/profile');
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Color(0xff426586),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) => _email = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) => _username = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onChanged: (value) => _confirmPassword = value,
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registerWithEmail,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff426586),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, color: Color(0xff648aae)),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _registerWithGoogle,
                  style: OutlinedButton.styleFrom(
                    primary: Color(0xff426586),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Color(0xff426586)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Image.asset('assets/google.png', height: 24),
                  label: Text('Sign up with Google'),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text(
                  'Already have an account? Sign In',
                  style: TextStyle(color: Color(0xff426586)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _googleSignIn = GoogleSignIn();

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _loginWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      final hashedPassword = _hashPassword(_password);
      await _storage.write(key: 'password', value: hashedPassword);

      Navigator.pushReplacementNamed(context, '/profile');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      // Step 2: Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Step 3: Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in to Firebase with Google credentials
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Check if this is a new user (registration)
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Generate default username
        final googleUsername = await _getNextGoogleUsername();

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'username': googleUsername,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Create user activity
        await _createUserActivity(userCredential.user!.uid);
      }

      Navigator.pushReplacementNamed(context, '/profile');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Helper methods copied from RegisterScreen
  Future<int> _getNextActivityId() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('user_activity').orderBy('activity_id', descending: true).limit(1).get();
    if (querySnapshot.docs.isEmpty) {
      return 1;
    } else {
      return querySnapshot.docs.first.get('activity_id') + 1;
    }
  }

  Future<void> _createUserActivity(String userId) async {
    final nextActivityId = await _getNextActivityId();

    await FirebaseFirestore.instance.collection('user_activity').doc(userId).set({
      'activity_id': nextActivityId,
      'e_count': 0,
      'l_count': 0,
      'j_count': 0,
      'game_1_level_count': 0,
      'game_2_level': 'null',
      'game_3_level': 'null',
      'user_id': userId,
    });
  }

  Future<String> _getNextGoogleUsername() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('users')
        .where('username', isGreaterThanOrEqualTo: 'GoogleUser')
        .where('username', isLessThan: 'GoogleUserz')
        .orderBy('username', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return 'GoogleUser1';
    } else {
      final lastUsername = querySnapshot.docs.first.get('username');
      final number = int.tryParse(lastUsername.replaceAll('GoogleUser', '')) ?? 0;
      return 'GoogleUser${number + 1}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Color(0xff426586),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) => _email = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) => _password = value,
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loginWithEmail,
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff426586),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 1, color: Color(0xff648aae)),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _signInWithGoogle,
                      style: OutlinedButton.styleFrom(
                        primary: Color(0xff426586),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Color(0xff426586)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Image.asset('assets/google.png', height: 24),
                      label: Text('Sign in with Google'),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(color: Color(0xff426586)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}