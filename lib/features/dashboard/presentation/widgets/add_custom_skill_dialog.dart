import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

Future<String?> showAddCustomSkillDialog(BuildContext context) {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Adicionar skill', style: AppStyle.heading16),
        content: Form(
          key: formKey,
          child: TextInput(
            title: 'Nome da skill',
            hint: 'Ex: GraphQL',
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
            label: 'Avaliar',
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
