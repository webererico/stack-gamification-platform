import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/inputs/email_input.dart';
import 'package:stack_gamification_platform/design_system/inputs/password_input.dart';
import 'package:stack_gamification_platform/features/authentication/signin/state_management/cubit/signin_cubit.dart';

class SignInForm extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onSignInPressed;

  const SignInForm({
    required this.onSignInPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignInCubit>().state;
    _emailController = TextEditingController(text: state.email);
    _passController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmailInput(email: _emailController),
          AppSpaces.vertical16,
          PasswordInput(pass: _passController),
          AppSpaces.vertical24,
          AppElevatedButton(
            label: 'Entrar',
            isLoading: widget.isLoading,
            onPressed: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                context.read<SignInCubit>().updateEmail(_emailController.text);
                context.read<SignInCubit>().updatePassword(
                  _passController.text,
                );
                widget.onSignInPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
