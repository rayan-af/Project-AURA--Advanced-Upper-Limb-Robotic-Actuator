import 'package:flutter/material.dart';

class AppTranslations {
  final Locale locale;

  AppTranslations(this.locale);

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations) ?? AppTranslations(const Locale('en'));
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'dashboard_title': {
      'ar': 'لوحة التحكم - Project: AURA',
      'en': 'Dashboard - Project: AURA',
      'fr': 'Tableau de Bord - Project: AURA',
      'de': 'Dashboard - Project: AURA',
      'zh': '仪表板 - Project: AURA',
      'ja': 'ダッシュボード - Project: AURA',
    },
    'telemetry_data': {
      'ar': 'البيانات الحيوية',
      'en': 'Telemetry Data',
      'fr': 'Données Télémétriques',
      'de': 'Telemetriedaten',
      'zh': '遥测数据',
      'ja': 'テレメトリーデータ',
    },
    'battery': {
      'ar': 'البطارية',
      'en': 'Battery',
      'fr': 'Batterie',
      'de': 'Batterie',
      'zh': '电池',
      'ja': 'バッテリー',
    },
    'signal_strength': {
      'ar': 'قوة الإشارة',
      'en': 'Signal Strength',
      'fr': 'Force du Signal',
      'de': 'Signalstärke',
      'zh': '信号强度',
      'ja': '信号強度',
    },
    'connection_status': {
      'ar': 'حالة الاتصال',
      'en': 'Connection Status',
      'fr': 'État de Connexion',
      'de': 'Verbindungsstatus',
      'zh': '连接状态',
      'ja': '接続状態',
    },
    'muscle_signal': {
      'ar': 'الإشارة العضلية',
      'en': 'Muscle Signal',
      'fr': 'Signal Musculaire',
      'de': 'Muskelsignal',
      'zh': '肌肉信号',
      'ja': '筋肉信号',
    },
    'calibrate_sensors_btn': {
      'ar': 'معايرة المستشعرات',
      'en': 'Calibrate Sensors',
      'fr': 'Étalonner les Capteurs',
      'de': 'Sensoren Kalibrieren',
      'zh': '校准传感器',
      'ja': 'センサーをキャリブレーション',
    },
    'calibration_title': {
      'ar': 'معايرة المستشعر',
      'en': 'Sensor Calibration',
      'fr': 'Étalonnage du Capteur',
      'de': 'Sensorkalibrierung',
      'zh': '传感器校准',
      'ja': 'センサーキャリブレーション',
    },
    'step_rest': {
      'ar': 'الراحة',
      'en': 'Rest',
      'fr': 'Repos',
      'de': 'Ruhe',
      'zh': '休息',
      'ja': '休憩',
    },
    'step_flex': {
      'ar': 'القبض',
      'en': 'Flex',
      'fr': 'Flexion',
      'de': 'Beugen',
      'zh': '收缩',
      'ja': '屈曲',
    },
    'step_done': {
      'ar': 'الانتهاء',
      'en': 'Done',
      'fr': 'Terminé',
      'de': 'Fertig',
      'zh': '完成',
      'ja': '完了',
    },
    'threshold_rest': {
      'ar': 'الراحة',
      'en': 'Rest',
      'fr': 'Repos',
      'de': 'Ruhe',
      'zh': '休息',
      'ja': '休憩',
    },
    'threshold_mid': {
      'ar': 'الوسط',
      'en': 'Mid',
      'fr': 'Moyen',
      'de': 'Mitte',
      'zh': '中间',
      'ja': '中間',
    },
    'live_signal': {
      'ar': 'الإشارة الحية',
      'en': 'Live Signal',
      'fr': 'Signal en Direct',
      'de': 'Live-Signal',
      'zh': '实时信号',
      'ja': 'ライブ信号',
    },
    'btn_start_calib': {
      'ar': 'بدء المعايرة',
      'en': 'Start Calibration',
      'fr': 'Démarrer',
      'de': 'Starten',
      'zh': '开始校准',
      'ja': '開始',
    },
    'btn_start_flex': {
      'ar': 'بدء القبض',
      'en': 'Start Flex',
      'fr': 'Démarrer Flexion',
      'de': 'Beugen Starten',
      'zh': '开始收缩',
      'ja': '屈曲を開始',
    },
    'btn_return': {
      'ar': 'العودة إلى اللوحة',
      'en': 'Return to Dashboard',
      'fr': 'Retour au Tableau de Bord',
      'de': 'Zurück zum Dashboard',
      'zh': '返回仪表板',
      'ja': 'ダッシュボードに戻る',
    },
    'calculating': {
      'ar': 'جاري الحساب...',
      'en': 'Calculating...',
      'fr': 'Calcul en cours...',
      'de': 'Berechne...',
      'zh': '计算中...',
      'ja': '計算中...',
    },
    'msg_measuring_rest': {
      'ar': 'جاري قياس وضع الراحة... لا تحرك عضلاتك',
      'en': 'Measuring rest state... Do not move your muscles',
      'fr': 'Mesure du repos... Ne bougez pas',
      'de': 'Messe Ruhezustand... Nicht bewegen',
      'zh': '正在测量休息状态... 请勿移动肌肉',
      'ja': '安静状態を測定中... 筋肉を動かさないでください',
    },
    'msg_measuring_flex': {
      'ar': 'جاري قياس نمط القبض... استمر في الضغط',
      'en': 'Measuring flex state... Keep flexing',
      'fr': 'Mesure de la flexion... Continuez à contracter',
      'de': 'Messe Beugezustand... Weiter beugen',
      'zh': '正在测量收缩状态... 保持收缩',
      'ja': '屈曲状態を測定中... 力を入れ続けてください',
    },
    'msg_calib_success': {
      'ar': 'تم إكمال المعايرة بنجاح!',
      'en': 'Calibration completed successfully!',
      'fr': 'Étalonnage terminé avec succès !',
      'de': 'Kalibrierung erfolgreich abgeschlossen!',
      'zh': '校准成功完成！',
      'ja': 'キャリブレーションが正常に完了しました！',
    },
    'msg_ready': {
      'ar': 'مستعد لبدء المعايرة. يرجى إراحة العضلات تماماً.',
      'en': 'Ready to start. Please relax your muscles completely.',
      'fr': 'Prêt. Veuillez relâcher vos muscles complètement.',
      'de': 'Bereit. Bitte entspannen Sie Ihre Muskeln vollständig.',
      'zh': '准备就绪。请完全放松您的肌肉。',
      'ja': '準備完了。筋肉を完全にリラックスさせてください。',
    },
    'msg_rest_saved': {
      'ar': 'تم تسجيل وضع الراحة. الآن، اقبض يدك بقوة لقياس أقصى جهد.',
      'en': 'Rest state saved. Now, flex your arm strongly.',
      'fr': 'État de repos enregistré. Maintenant, contractez fermement.',
      'de': 'Ruhezustand gespeichert. Nun beugen Sie stark.',
      'zh': '休息状态已保存。现在，请用力收缩您的手臂。',
      'ja': '安静状態が保存されました。今度は腕を強く曲げてください。',
    },
    'connection_error': {
      'ar': 'خطأ في الاتصال:',
      'en': 'Connection Error:',
      'fr': 'Erreur de Connexion :',
      'de': 'Verbindungsfehler:',
      'zh': '连接错误：',
      'ja': '接続エラー：',
    },
    'status_connected': {
      'ar': 'متصل',
      'en': 'Connected',
      'fr': 'Connecté',
      'de': 'Verbunden',
      'zh': '已连接',
      'ja': '接続済み',
    },
    'status_disconnected': {
      'ar': 'غير متصل',
      'en': 'Disconnected',
      'fr': 'Déconnecté',
      'de': 'Getrennt',
      'zh': '未连接',
      'ja': '切断されました',
    },
    'lang_ar': {
      'ar': 'العربية', 'en': 'Arabic', 'fr': 'Arabe', 'de': 'Arabisch', 'zh': '阿拉伯语', 'ja': 'アラビア語',
    },
    'lang_en': {
      'ar': 'English', 'en': 'English', 'fr': 'Anglais', 'de': 'Englisch', 'zh': '英语', 'ja': '英語',
    },
    'lang_fr': {
      'ar': 'الفرنسية', 'en': 'French', 'fr': 'Français', 'de': 'Französisch', 'zh': '法语', 'ja': 'フランス語',
    },
    'lang_de': {
      'ar': 'الألمانية', 'en': 'German', 'fr': 'Allemand', 'de': 'Deutsch', 'zh': '德语', 'ja': 'ドイツ語',
    },
    'lang_zh': {
      'ar': 'الصينية', 'en': 'Chinese', 'fr': 'Chinois', 'de': 'Chinesisch', 'zh': '中文', 'ja': '中国語',
    },
    'lang_ja': {
      'ar': 'اليابانية', 'en': 'Japanese', 'fr': 'Japonais', 'de': 'Japanisch', 'zh': '日语', 'ja': '日本語',
    },
  };

  String text(String key) {
    return _localizedValues[key]?[locale.languageCode] ?? _localizedValues[key]?['en'] ?? key;
  }
}

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  const AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar', 'fr', 'de', 'zh', 'ja'].contains(locale.languageCode);

  @override
  Future<AppTranslations> load(Locale locale) async {
    return AppTranslations(locale);
  }

  @override
  bool shouldReload(AppTranslationsDelegate old) => false;
}

extension AppTranslationsExtension on BuildContext {
  String tr(String key) {
    return AppTranslations.of(this).text(key);
  }
}
