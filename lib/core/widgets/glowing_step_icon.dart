import 'package:flutter/material.dart';

class GlowingStepIcon extends StatefulWidget {
  final bool isActive;
  final bool isCompleted;
  final String label;

  const GlowingStepIcon({
    super.key,
    required this.isActive,
    required this.isCompleted,
    required this.label,
  });

  @override
  State<GlowingStepIcon> createState() => _GlowingStepIconState();
}

class _GlowingStepIconState extends State<GlowingStepIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 2.0, end: 15.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant GlowingStepIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color baseColor = widget.isCompleted 
        ? Colors.tealAccent 
        : (widget.isActive ? Colors.cyanAccent : Colors.grey.withOpacity(0.3));

    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isCompleted ? Colors.teal : (widget.isActive ? Colors.cyan.withOpacity(0.2) : Colors.transparent),
                border: Border.all(color: baseColor, width: 2),
                boxShadow: [
                  if (widget.isActive) 
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.6),
                      blurRadius: _animation.value, 
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Icon(
                widget.isCompleted ? Icons.check : Icons.circle,
                color: baseColor,
                size: 24,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          widget.label,
          style: TextStyle(
            color: widget.isActive || widget.isCompleted ? Colors.white : Colors.grey,
            fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
