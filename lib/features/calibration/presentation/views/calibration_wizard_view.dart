import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_translations.dart';
import '../controller/calibration_controller.dart';
import '../../../../core/widgets/liquid_neon_signal_bar.dart';
import '../../../../core/widgets/glowing_step_icon.dart';

class CalibrationWizardView extends ConsumerStatefulWidget {
  const CalibrationWizardView({super.key});

  @override
  ConsumerState<CalibrationWizardView> createState() => _CalibrationWizardViewState();
}

class _CalibrationWizardViewState extends ConsumerState<CalibrationWizardView> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wizardProvider);
    final notifier = ref.read(wizardProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.tr('calibration_title')),
      ),
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.secondary.withOpacity(0.15),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.transparent),
          ),
          // Main Content
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStepperIndicator(state.currentStep, theme),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                context.tr(state.instructionText),
                                key: ValueKey<String>(state.instructionText),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  letterSpacing: 0.5,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Expanded(
                            child: _buildDynamicSignalVisualizer(context, state, theme),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildActionButtons(context, state, notifier, theme),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  ),
    );
  }

  Widget _buildStepperIndicator(int currentStep, ThemeData theme) {
    return Row(
      children: [
        Expanded(child: GlowingStepIcon(label: context.tr('step_rest'), isActive: currentStep == 0, isCompleted: currentStep > 0)),
        _buildStepDivider(currentStep >= 1, theme),
        Expanded(child: GlowingStepIcon(label: context.tr('step_flex'), isActive: currentStep == 1, isCompleted: currentStep > 1)),
        _buildStepDivider(currentStep >= 2, theme),
        Expanded(child: GlowingStepIcon(label: context.tr('step_done'), isActive: currentStep == 2, isCompleted: currentStep > 2)),
      ],
    );
  }

  Widget _buildStepDivider(bool isCompleted, ThemeData theme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 3,
          decoration: BoxDecoration(
            color: isCompleted ? theme.colorScheme.primary : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicSignalVisualizer(BuildContext context, WizardState state, ThemeData theme) {
    final double maxSignal = 1024.0;
    final double currentPercentage = (state.dynamicLiveValue / maxSignal).clamp(0.0, 1.0);
    final double baselinePercentage = (state.baseline / maxSignal).clamp(0.0, 1.0);
    final double midPercentage = (state.midpoint / maxSignal).clamp(0.0, 1.0);

    // Prevent threshold labels from rendering exactly on top of each other
    double baselineLabelBottom = 350 * baselinePercentage - 12;
    double midLabelBottom = 350 * midPercentage - 12;

    if (state.currentStep == 2 && (midLabelBottom - baselineLabelBottom).abs() < 35) {
      midLabelBottom = baselineLabelBottom + 35;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.currentStep >= 1)
                    SizedBox(
                      width: 90,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          if (state.currentStep == 2)
                            Positioned(
                              bottom: midLabelBottom,
                              right: 0,
                              child: _buildThresholdLabel(context.tr('threshold_mid'), state.midpoint, theme.colorScheme.error),
                            ),
                          Positioned(
                            bottom: baselineLabelBottom,
                            right: 0,
                            child: _buildThresholdLabel(context.tr('threshold_rest'), state.baseline, theme.colorScheme.secondary),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 24),
                  ScaleTransition(
                    scale: state.isSampling ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        LiquidNeonSignalBar(
                          fillPercentage: currentPercentage,
                          rawValue: state.dynamicLiveValue,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        Text(
          context.tr('live_signal'),
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70, letterSpacing: 1.5),
        ),
      ],
    );
  }

  Widget _buildThresholdLabel(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WizardState state, CalibrationWizardNotifier notifier, ThemeData theme) {
    if (state.isSampling) {
      return _buildPremiumButton(
        text: context.tr('calculating'),
        icon: null,
        color: Colors.grey.shade800,
        onPressed: () {},
        isLoading: true,
        theme: theme,
      );
    }

    if (state.currentStep == 0) {
      return _buildPremiumButton(
        text: context.tr('btn_start_calib'),
        icon: Icons.play_arrow_rounded,
        color: theme.colorScheme.primary,
        onPressed: notifier.runNextCalibrationStep,
        theme: theme,
      );
    }

    if (state.currentStep == 1) {
      return _buildPremiumButton(
        text: context.tr('btn_start_flex'),
        icon: Icons.fitness_center_rounded,
        color: theme.colorScheme.secondary,
        onPressed: notifier.runNextCalibrationStep,
        theme: theme,
      );
    }

    return _buildPremiumButton(
      text: context.tr('btn_return'),
      icon: Icons.check_circle_rounded,
      color: theme.colorScheme.primary,
      onPressed: () => Navigator.of(context).pop(),
      theme: theme,
    );
  }

  Widget _buildPremiumButton({
    required String text,
    IconData? icon,
    required Color color,
    required VoidCallback onPressed,
    bool isLoading = false,
    required ThemeData theme,
  }) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isLoading 
            ? [] 
            : [BoxShadow(color: color.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, size: 28),
                  if (icon != null) const SizedBox(width: 12),
                  Text(text, style: const TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                ],
              ),
      ),
    );
  }
}
