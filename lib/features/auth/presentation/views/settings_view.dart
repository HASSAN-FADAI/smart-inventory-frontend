import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_state.dart';
import 'package:inventory_managment/features/auth/presentation/views/auth_view.dart';
import 'package:inventory_managment/features/auth/widget/settings_item_widget.dart';
import 'package:inventory_managment/shared/custom_snack_bar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (conrxt) => const AuthView()),
              (route) => false,
            );
          } else if (state is AuthError) {
            CustomSnackBar.show(context, message: state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(top: 10),
                children: [
                  SettingsItemWidget(
                    icon: Icons.person_outline,
                    title: 'تعديل البروفايل',
                    onTap: () {},
                  ),
                  const Divider(height: 1, thickness: 1, indent: 60),
                  SettingsItemWidget(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    textColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () {
                      context.read<AuthCubit>().logout();
                    },
                  ),
                ],
              ),

              if (state is AuthLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
