import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';

class ErrorState {
  final String title;
  final String message;
  final VoidCallback? onTryAgain;
  ErrorState({
    this.title = 'Algo deu errado.',
    this.message = 'Tente novamente',
    this.onTryAgain,
  });
}

class BasePage extends StatelessWidget {
  final String? title;
  final EdgeInsets? padding;
  final Widget body;
  final bool isLoading;
  final ErrorState? error;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const BasePage({
    required this.body,
    this.title,
    this.isLoading = false,
    this.padding,
    this.error,
    this.actions,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), actions: actions)
          : null,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(
          padding: padding ?? EdgeInsets.all(AppPadding.m),
          child: isLoading ? const AppLoader() : body,
        ),
      ),
    );
  }
}
