import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/auth/widget/costum_user_text_field.dart';
import 'package:inventory_managment/features/auth/widget/custom_auth_button.dart';

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
    return GestureDetector(
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
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
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
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
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
                                  hintText: 'Full Name',
                                  isPassword: false,
                                  controller: nameController,
                                  icon: const Icon(Icons.person_outline),
                                  prefixColor: Colors.grey.shade500,
                                ),
                                const Gap(20),
                              ],

                              CustomUserTextField(
                                hintText: 'Email',
                                isPassword: false,
                                controller: emailController,
                                icon: const Icon(Icons.email_outlined),
                                prefixColor: Colors.grey.shade500,
                              ),
                              const Gap(20),

                              CustomUserTextField(
                                hintText: 'Password',
                                isPassword: true,
                                controller: passwordController,
                                icon: const Icon(Icons.lock_outlined),
                                prefixColor: Colors.grey.shade500,
                              ),
                              const Gap(30),

                              CustomAuthButton(
                                text: isLoginMode ? 'Login' : 'Create Account',
                                textColor: Colors.white,
                                onTap: () {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  if (isLoginMode) {
                                  } else {}
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
    );
  }
}
