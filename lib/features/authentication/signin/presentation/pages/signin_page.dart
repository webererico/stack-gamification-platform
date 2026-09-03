import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_text_button.dart';
import 'package:stack_gamification_platform/design_system/buttons/google_sign_in_button.dart';
import 'package:stack_gamification_platform/features/authentication/signin/presentation/widgets/signin_form.dart';
import 'package:stack_gamification_platform/features/authentication/signin/state_management/cubit/signin_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignInCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppPadding.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpaces.vertical48,
                const _StackUpLogo(),
                AppSpaces.vertical32,
                Text('Bem-vindo de volta!', style: AppStyle.display28),
                AppSpaces.vertical4,
                Text(
                  'Entre para acompanhar sua evolução de skills.',
                  style: AppStyle.body16,
                ),
                AppSpaces.vertical32,
                BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state.status == AuthenticateStatus.authenticated) {
                      context.goNamed(RouteNames.dashboard);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SignInForm(
                          isLoading: state.isLoading,
                          onSignInPressed: () =>
                              context.read<SignInCubit>().login(),
                        ),
                        AppSpaces.vertical20,
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text('ou', style: AppStyle.subtitle12),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        AppSpaces.vertical20,
                        GoogleSignInButton(
                          isLoading: state.isLoading,
                          onPressed: () =>
                              context.read<SignInCubit>().loginWithGoogle(),
                        ),
                      ],
                    );
                  },
                ),
                AppSpaces.vertical16,
                Center(
                  child: AppTextButton(
                    label: 'Não tem conta? Cadastre-se',
                    onPressed: () => context.pushNamed(RouteNames.signUp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StackUpLogo extends StatelessWidget {
  const _StackUpLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.border),
            borderRadius: AppBorder.radius16,
          ),
          child: const Icon(
            Icons.arrow_upward_rounded,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
        AppSpaces.horizontal12,
        Text('Stack Up', style: AppStyle.heading20),
      ],
    );
  }
}
