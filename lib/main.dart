import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_managment/core/services/locator.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:inventory_managment/features/auth/presentation/views/auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AuthCubit>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.vazirmatnTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: AuthView(),
      ),
    );
  }
}
