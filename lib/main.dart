import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_managment/features/auth/views/auth_view.dart';
import 'package:inventory_managment/features/dashboard/views/Product_Management_view.dart';
import 'package:inventory_managment/features/dashboard/views/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.vazirmatnTextTheme(Theme.of(context).textTheme),
      ),
      home: ProductManagementView(),
    );
  }
}
