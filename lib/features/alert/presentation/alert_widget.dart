import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/features/alert/cubit/alert_area_cubit.dart';
import 'package:stack_gamification_platform/features/alert/domain/alert.dart';

class AlertWidget extends StatefulWidget {
  final Alert alert;
  const AlertWidget({required this.alert, super.key});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.alert.duration)
            .then((value) => _controller.reverse());
      } else if (status == AnimationStatus.dismissed) {
        getIt<AlertAreaCubit>().removeAlert(widget.alert);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: switch (widget.alert.type) {
                AlertType.success => const Color(0xffd6f5ea),
                AlertType.error => const Color(0xfffbdde1),
                AlertType.warning => const Color(0xfffff1cf),
              },
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  switch (widget.alert.type) {
                    AlertType.success => Icons.check_circle,
                    AlertType.error => Icons.cancel_outlined,
                    AlertType.warning => Icons.warning_amber_rounded,
                  },
                  color: switch (widget.alert.type) {
                    AlertType.success => const Color(0xff2ecc71),
                    AlertType.error => const Color(0xffe4536b),
                    AlertType.warning => const Color(0xffffb020),
                  },
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(widget.alert.title)),
              ],
            ),
          ),
        );
      },
    );
  }
}
