import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/app_translations.dart';
import '../../../../core/localization/locale_provider.dart';
import '../../../../core/widgets/accessibility_metric_card.dart';
import '../controller/dashboard_controller.dart';
import 'calibration_wizard_view.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetryAsync = ref.watch(dashboardControllerProvider);
    final theme = Theme.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('dashboard_title')),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language, color: Colors.white),
            onSelected: (Locale newLocale) {
              ref.read(localeProvider.notifier).setLocale(newLocale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              PopupMenuItem(value: const Locale('en', 'US'), child: Text(context.tr('lang_en'))),
              PopupMenuItem(value: const Locale('ar', 'QA'), child: Text(context.tr('lang_ar'))),
              PopupMenuItem(value: const Locale('fr', 'FR'), child: Text(context.tr('lang_fr'))),
              PopupMenuItem(value: const Locale('de', 'DE'), child: Text(context.tr('lang_de'))),
              PopupMenuItem(value: const Locale('zh', 'CN'), child: Text(context.tr('lang_zh'))),
              PopupMenuItem(value: const Locale('ja', 'JP'), child: Text(context.tr('lang_ja'))),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.tr('telemetry_data'),
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: telemetryAsync.when(
                  data: (telemetry) {
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        AccessibilityMetricCard(
                          label: context.tr('battery'),
                          value: '${telemetry.batteryLevel}%',
                          icon: Icons.battery_charging_full,
                          accentColor: const Color(0xFF00BFA5),
                        ),
                        AccessibilityMetricCard(
                          label: context.tr('signal_strength'),
                          value: '${telemetry.signalStrength} dBm',
                          icon: Icons.wifi,
                          accentColor: theme.colorScheme.secondary,
                        ),
                        AccessibilityMetricCard(
                          label: context.tr('connection_status'),
                          value: context.tr(telemetry.connectionStatus),
                          icon: Icons.bluetooth_connected,
                          accentColor: Colors.purpleAccent,
                        ),
                        AccessibilityMetricCard(
                          label: context.tr('muscle_signal'),
                          value: '${telemetry.currentSignal}',
                          icon: Icons.monitor_heart,
                          accentColor: theme.colorScheme.error,
                        ),
                      ],
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator(color: theme.primaryColor)),
                  error: (err, stack) => Center(child: Text('${context.tr("connection_error")} $err', style: TextStyle(color: theme.colorScheme.error))),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(64),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 5,
                  shadowColor: theme.primaryColor.withOpacity(0.5),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const CalibrationWizardView(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.05),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
                            child: child,
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                icon: const Icon(Icons.settings_suggest, size: 28),
                label: Text(
                  context.tr('calibrate_sensors_btn'),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
  }
}
