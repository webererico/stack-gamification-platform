import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

final _emailRegex = RegExp(
  r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])',
);

class EmailInput extends StatelessWidget {
  const EmailInput({required this.email, super.key});

  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      title: 'E-mail',
      initialText: email.text,
      textInputType: TextInputType.emailAddress,
      action: TextInputAction.next,
      hint: 'Digite seu e-mail',
      validator: (value) {
        return value == null || value.isEmpty || !_emailRegex.hasMatch(value)
            ? 'E-mail inválido'
            : null;
      },
      onChanged: (value) => email.text = value,
    );
  }
}
