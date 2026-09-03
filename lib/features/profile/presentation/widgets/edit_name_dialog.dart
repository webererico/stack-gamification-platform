import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

Future<String?> showEditNameDialog(BuildContext context, String currentName) {
  final controller = TextEditingController(text: currentName);
  final formKey = GlobalKey<FormState>();
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Editar nome', style: AppStyle.heading16),
        content: Form(
          key: formKey,
          child: TextInput(
            title: 'Nome',
            hint: 'Seu nome',
            initialText: currentName,
            onChanged: (value) => controller.text = value,
            validator: (value) =>
                value == null || value.trim().isEmpty ? 'Digite um nome' : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          AppElevatedButton(
            label: 'Salvar',
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(controller.text.trim());
              }
            },
          ),
        ],
      );
    },
  );
}
