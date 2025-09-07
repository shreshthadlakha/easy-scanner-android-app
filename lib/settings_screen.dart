import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDarkMode = themeMode == ThemeMode.dark || 
        (themeMode == ThemeMode.system && 
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black87,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          _buildSectionHeader('Appearance', isDarkMode),
          const SizedBox(height: 8),
          _buildThemeCard(context, themeMode, themeNotifier, isDarkMode),
          
          const SizedBox(height: 24),
          
          // App Section
          _buildSectionHeader('App', isDarkMode),
          const SizedBox(height: 8),
          _buildSettingsCard(
            context,
            [
              _buildSettingsTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () {
                  HapticFeedback.lightImpact();
                  _showAboutDialog(context);
                },
                isDarkMode: isDarkMode,
              ),
              _buildSettingsTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help with the app',
                onTap: () {
                  HapticFeedback.lightImpact();
                  // Navigate to help screen
                },
                isDarkMode: isDarkMode,
              ),
              _buildSettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'View our privacy policy',
                onTap: () {
                  HapticFeedback.lightImpact();
                  // Navigate to privacy policy
                },
                isDarkMode: isDarkMode,
              ),
            ],
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildThemeCard(BuildContext context, ThemeMode currentTheme, 
      ThemeNotifier themeNotifier, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.palette_outlined,
                  color: isDarkMode ? Colors.white : Colors.black87,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Theme Options
            Column(
              children: [
                _buildThemeOption(
                  'Light',
                  Icons.light_mode,
                  ThemeMode.light,
                  currentTheme,
                  themeNotifier,
                  isDarkMode,
                ),
                _buildThemeOption(
                  'Dark',
                  Icons.dark_mode,
                  ThemeMode.dark,
                  currentTheme,
                  themeNotifier,
                  isDarkMode,
                ),
                _buildThemeOption(
                  'System',
                  Icons.settings_system_daydream,
                  ThemeMode.system,
                  currentTheme,
                  themeNotifier,
                  isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String title, IconData icon, ThemeMode themeMode,
      ThemeMode currentTheme, ThemeNotifier themeNotifier, bool isDarkMode) {
    final isSelected = currentTheme == themeMode;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isSelected 
            ? const Color(0xFF6366F1)
            : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? const Color(0xFF6366F1)
              : (isDarkMode ? Colors.white : Colors.black87),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: Radio<ThemeMode>(
        value: themeMode,
        groupValue: currentTheme,
        onChanged: (value) {
          if (value != null) {
            HapticFeedback.lightImpact();
            themeNotifier.setTheme(value);
          }
        },
        activeColor: const Color(0xFF6366F1),
      ),
      onTap: () {
        HapticFeedback.lightImpact();
        themeNotifier.setTheme(themeMode);
      },
    );
  }

  Widget _buildSettingsCard(BuildContext context, List<Widget> children, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? const Color(0xFF1F1F1F) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDarkMode ? Colors.white : Colors.black87,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
      ),
      onTap: onTap,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Document Scanner',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.document_scanner,
        size: 64,
        color: Color(0xFF6366F1),
      ),
      children: [
        const Text(
          'A powerful document scanning app that helps you digitize your documents with ease.',
        ),
      ],
    );
  }
}