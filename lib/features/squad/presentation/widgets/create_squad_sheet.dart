import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/skill_catalog.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/inputs/text_input.dart';

class CreateSquadResult {
  final String name;
  final String stack;
  const CreateSquadResult({required this.name, required this.stack});
}

Future<CreateSquadResult?> showCreateSquadSheet(BuildContext context) {
  return showModalBottomSheet<CreateSquadResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _CreateSquadSheetContent(),
  );
}

class _CreateSquadSheetContent extends StatefulWidget {
  const _CreateSquadSheetContent();

  @override
  State<_CreateSquadSheetContent> createState() =>
      _CreateSquadSheetContentState();
}

class _CreateSquadSheetContentState extends State<_CreateSquadSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _stack = SkillCatalog.availableStacks.first;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nova squad', style: AppStyle.heading20),
              AppSpaces.vertical16,
              TextInput(
                title: 'Nome da squad',
                hint: 'Ex: Time Flutter',
                onChanged: (value) => _nameController.text = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Digite um nome'
                    : null,
              ),
              AppSpaces.vertical16,
              Text('Stack', style: AppStyle.title14),
              AppSpaces.vertical8,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final stack in SkillCatalog.availableStacks)
                    ChoiceChip(
                      label: Text(stack),
                      selected: _stack == stack,
                      onSelected: (_) => setState(() => _stack = stack),
                    ),
                ],
              ),
              AppSpaces.vertical24,
              AppElevatedButton(
                label: 'Criar squad',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop(
                      CreateSquadResult(
                        name: _nameController.text.trim(),
                        stack: _stack,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
