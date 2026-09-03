import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/inputs/email_input.dart';
import 'package:stack_gamification_platform/design_system/inputs/name_input.dart';
import 'package:stack_gamification_platform/design_system/inputs/password_input.dart';
import 'package:stack_gamification_platform/features/authentication/signup/state_management/cubit/signup_cubit.dart';

class SignUpForm extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onSignUpPressed;

  const SignUpForm({
    required this.onSignUpPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignUpCubit>().state;
    _nameController = TextEditingController(text: state.name);
    _emailController = TextEditingController(text: state.email);
    _passController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
          NameInput(name: _nameController),
          AppSpaces.vertical16,
          EmailInput(email: _emailController),
          AppSpaces.vertical16,
          PasswordInput(pass: _passController),
          AppSpaces.vertical24,
          AppElevatedButton(
            label: 'Criar conta',
            isLoading: widget.isLoading,
            onPressed: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                final cubit = context.read<SignUpCubit>();
                cubit.updateName(_nameController.text);
                cubit.updateEmail(_emailController.text);
                cubit.updatePassword(_passController.text);
                widget.onSignUpPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
