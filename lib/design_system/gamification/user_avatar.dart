import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';

/// Shows a developer's Google profile photo when available, falling back
/// to their initial letter on a tinted background.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.name,
    this.photoUrl,
    this.radius = 20,
    this.foregroundColor = AppColors.primaryColor,
    super.key,
  });

  final String name;
  final String? photoUrl;
  final double radius;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;
    return CircleAvatar(
      radius: radius,
      backgroundColor: foregroundColor.withValues(alpha: 0.15),
      backgroundImage: hasPhoto ? NetworkImage(photoUrl!) : null,
      child: hasPhoto
          ? null
          : Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                color: foregroundColor,
                fontWeight: FontWeight.bold,
                fontSize: radius * 0.8,
              ),
            ),
    );
  }
}
