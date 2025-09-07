import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.system:
        state = ThemeMode.light;
        break;
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.system;
        break;
    }
  }
}

// App settings provider
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

class AppSettings {
  final bool autoBackup;
  final bool cloudSync;
  final String defaultScanQuality;
  final bool autoEnhance;
  final bool showTutorial;
  final String language;

  const AppSettings({
    this.autoBackup = false,
    this.cloudSync = false,
    this.defaultScanQuality = 'High',
    this.autoEnhance = true,
    this.showTutorial = true,
    this.language = 'en',
  });

  AppSettings copyWith({
    bool? autoBackup,
    bool? cloudSync,
    String? defaultScanQuality,
    bool? autoEnhance,
    bool? showTutorial,
    String? language,
  }) {
    return AppSettings(
      autoBackup: autoBackup ?? this.autoBackup,
      cloudSync: cloudSync ?? this.cloudSync,
      defaultScanQuality: defaultScanQuality ?? this.defaultScanQuality,
      autoEnhance: autoEnhance ?? this.autoEnhance,
      showTutorial: showTutorial ?? this.showTutorial,
      language: language ?? this.language,
    );
  }
}

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(const AppSettings());

  void updateAutoBackup(bool value) {
    state = state.copyWith(autoBackup: value);
  }

  void updateCloudSync(bool value) {
    state = state.copyWith(cloudSync: value);
  }

  void updateScanQuality(String quality) {
    state = state.copyWith(defaultScanQuality: quality);
  }

  void updateAutoEnhance(bool value) {
    state = state.copyWith(autoEnhance: value);
  }

  void updateShowTutorial(bool value) {
    state = state.copyWith(showTutorial: value);
  }

  void updateLanguage(String language) {
    state = state.copyWith(language: language);
  }
}