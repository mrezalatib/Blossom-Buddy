import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Handle login
//   Future<void> _login() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // Navigate to the home page after login
//       Navigator.pushReplacementNamed(context, '/home');  // You can define your home page
//     } catch (e) {
//       // Handle errors (e.g., incorrect credentials)
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Login failed: $e'),
//         duration: Duration(seconds: 2),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//             // Add additional UI elements like sign-up, forgot password, etc.
//           ],
//         ),
//       ),
//     );
//   }
// }
