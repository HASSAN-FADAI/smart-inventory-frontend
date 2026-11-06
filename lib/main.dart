import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory_managment/core/services/locator.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:inventory_managment/features/auth/presentation/views/auth_view.dart';
import 'package:inventory_managment/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:inventory_managment/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_cubit.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<DashboardCubit>()),
        BlocProvider(create: (context) => getIt<ProductsCubit>()),
        BlocProvider(create: (context) => getIt<SalesCubit>()),
      ],
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
