import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    required this.pass,
    this.title = 'Senha',
    this.hint = 'Digite sua senha',
    super.key,
  });

  final TextEditingController pass;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      title: title,
      hint: hint,
      action: TextInputAction.done,
      initialText: pass.text,
      obscure: true,
      validator: (value) {
        if (value != null && value.length >= 6) {
          return null;
        }
        return 'Senha inválida (mínimo 6 dígitos)';
      },
      onChanged: (value) => pass.text = value,
    );
  }
}
