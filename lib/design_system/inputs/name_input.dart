import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

class NameInput extends StatelessWidget {
  const NameInput({required this.name, super.key});

  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      title: 'Nome',
      initialText: name.text,
      textInputType: TextInputType.name,
      action: TextInputAction.next,
      hint: 'Como podemos te chamar?',
      validator: (value) {
        return value == null || value.trim().length < 2
            ? 'Digite seu nome'
            : null;
      },
      onChanged: (value) => name.text = value,
    );
  }
}
