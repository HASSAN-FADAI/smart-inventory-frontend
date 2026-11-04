import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:inventory_managment/features/auth/presentation/cubit/auth_state.dart';
import 'package:inventory_managment/features/auth/widget/costum_user_text_field.dart';
import 'package:inventory_managment/features/auth/widget/custom_auth_button.dart';
import 'package:inventory_managment/features/dashboard/views/dashboard_view.dart';
import 'package:inventory_managment/shared/custom_snack_bar.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLoginMode = true;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => const DashboardView()),
          );
        } else if (state is AuthError) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.scaffoldPrimary,
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: AppColors.secondry,
                        child: SizedBox(
                          width: 450,
                          height: 540,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isLoginMode = true;
                                            formKey.currentState?.reset();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isLoginMode
                                                ? AppColors.primary
                                                : Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft: Radius.circular(
                                                    15,
                                                  ),
                                                ),
                                          ),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: isLoginMode
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isLoginMode = false;
                                            formKey.currentState?.reset();
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: !isLoginMode
                                                ? AppColors.primary
                                                : Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight: Radius.circular(
                                                    15,
                                                  ),
                                                ),
                                          ),
                                          child: Text(
                                            'Register',
                                            style: TextStyle(
                                              color: !isLoginMode
                                                  ? Colors.white
                                                  : Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(40),

                                if (!isLoginMode) ...[
                                  CustomUserTextField(
                                    key: const ValueKey('full_name'),
                                    hintText: 'Full Name',
                                    isPassword: false,
                                    controller: nameController,
                                    icon: const Icon(Icons.person_outline),
                                    prefixColor: Colors.grey.shade500,
                                  ),
                                  const Gap(20),
                                ],

                                CustomUserTextField(
                                  key: const ValueKey('email'),
                                  hintText: 'Email',
                                  isPassword: false,
                                  controller: emailController,
                                  icon: const Icon(Icons.email_outlined),
                                  prefixColor: Colors.grey.shade500,
                                ),
                                const Gap(20),

                                CustomUserTextField(
                                  key: const ValueKey('password'),
                                  hintText: 'Password',
                                  isPassword: true,
                                  controller: passwordController,
                                  icon: const Icon(Icons.lock_outlined),
                                  prefixColor: Colors.grey.shade500,
                                ),
                                const Gap(30),

                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (BuildContext context, state) {
                                    final isLocked = state is AuthLocked;
                                    final remainingSeconds = isLocked
                                        ? state.remainingSeconds
                                        : 0;
                                    final loading = state is AuthLoading;
                                    final authCubit = context.read<AuthCubit>();
                                    return CustomAuthButton(
                                      text: isLocked
                                          ? 'انتظر ($remainingSeconds ثانية)'
                                          : (isLoginMode
                                                ? 'Login'
                                                : 'Create Account'),
                                      textColor: Colors.white,
                                      widget: loading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : null,
                                      // تعطيل الزر تماماً إذا كان في حالة تحميل أو حظر مؤقت
                                      onTap: (loading || isLocked)
                                          ? null
                                          : () {
                                              if (!formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              if (isLoginMode) {
                                                authCubit.login(
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                );
                                              } else {
                                                authCubit.register(
                                                  name: nameController.text
                                                      .trim(),
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim(),
                                                );
                                              }
                                            },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
