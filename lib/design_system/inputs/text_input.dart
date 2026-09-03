import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';

class TextInput extends StatefulWidget {
  final String title;
  final String hint;
  final Function(String) onChanged;
  final TextInputType? textInputType;
  final String? initialText;
  final bool obscure;
  final TextInputAction? action;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const TextInput({
    required this.title,
    required this.hint,
    required this.onChanged,
    this.textInputType,
    this.initialText,
    this.obscure = false,
    this.inputFormatters,
    this.action,
    this.validator,
    super.key,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title, style: AppStyle.title14),
        const SizedBox(height: 6),
        TextFormField(
          validator: widget.validator,
          initialValue: widget.initialText,
          textInputAction: widget.action,
          onChanged: widget.onChanged,
          obscureText: widget.obscure && hidePassword,
          keyboardType: widget.textInputType,
          inputFormatters: widget.inputFormatters,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.all(16),
            isCollapsed: false,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.obscure
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
