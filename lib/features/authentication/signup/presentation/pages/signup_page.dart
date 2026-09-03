import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/features/authentication/signin/state_management/cubit/signin_cubit.dart'
    show AuthenticateStatus;
import 'package:stack_gamification_platform/features/authentication/signup/presentation/widgets/signup_form.dart';
import 'package:stack_gamification_platform/features/authentication/signup/state_management/cubit/signup_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Criar conta')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppPadding.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Junte-se à sua squad', style: AppStyle.display28),
                AppSpaces.vertical4,
                Text(
                  'Crie sua conta e comece a mapear suas skills técnicas.',
                  style: AppStyle.body16,
                ),
                AppSpaces.vertical32,
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state.status == AuthenticateStatus.authenticated) {
                      context.goNamed(RouteNames.squadSelect);
                    }
                  },
                  builder: (context, state) {
                    return SignUpForm(
                      isLoading: state.isLoading,
                      onSignUpPressed: () =>
                          context.read<SignUpCubit>().signUp(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
