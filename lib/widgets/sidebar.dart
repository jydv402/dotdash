import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/models/colors.dart';
import 'package:morse_web_play/models/nav_model.dart';
import 'package:morse_web_play/providers/theme_provider.dart';

/// Custom sidebar widget for navigation.
class CustomSidebar extends ConsumerWidget {
  final AppSection selectedSection;
  final ValueChanged<AppSection> onSectionSelected;
  final double maxWidth;
  final bool expanded;

  const CustomSidebar({
    super.key,
    required this.selectedSection,
    required this.onSectionSelected,
    required this.maxWidth,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final barItems = [
      (AppSection.converter, Ph.house_duotone, Ph.house_fill, 'Convert'),
      (AppSection.book, Ph.book_duotone, Ph.book_open_fill, 'Book'),
      (AppSection.credits, Ph.heart_duotone, Ph.heart_fill, 'Credits'),
    ];

    return Container(
      width: maxWidth > 1000 ? 200 : 80,
      margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Logo
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: expanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              spacing: 6,
              children: [
                Image.asset('assets/morseLogo.png', height: 30),
                const SizedBox(height: 4),
                if (expanded)
                  const Text(
                    'DotDash',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Nav items with animated pill background
          Stack(
            children: [
              // Animated pill background
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutSine,
                  alignment: Alignment(
                    0,
                    -1 + (selectedSection.index * (2 / (barItems.length - 1))),
                  ),
                  child: FractionallySizedBox(
                    heightFactor: 1 / barItems.length,
                    child: Center(
                      child: Container(
                        width: maxWidth > 1000 ? 190 : 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: violetMorse,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Actual nav items
              Column(
                children: [
                  for (final (section, icon, selectedIcon, label) in barItems)
                    _SidebarItem(
                      isSelected: section == selectedSection,
                      icon: icon,
                      selectedIcon: selectedIcon,
                      label: label,
                      onTap: () => onSectionSelected(section),
                      expanded: expanded,
                    ),
                ],
              ),
            ],
          ),
          const Spacer(),

          // Theme switcher button
          _SidebarItem(
            isSelected: false,
            icon: isDark ? Ph.moon_duotone : Ph.sun_duotone,
            selectedIcon: isDark ? Ph.moon_duotone : Ph.sun_duotone,
            label: isDark ? 'Dark Mode' : 'Light Mode',
            onTap: () {
              ref
                  .read(themeProvider.notifier)
                  .toggleTheme(Theme.of(context).brightness);
            },
            expanded: expanded,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool expanded;

  const _SidebarItem({
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color = isSelected
        ? Colors.white
        : (isDark ? Colors.grey : Colors.black87);

    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: colorScheme.primary.withValues(alpha: 0.3),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: expanded
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            spacing: expanded ? 12 : 0,
            children: [
              Iconify(isSelected ? selectedIcon : icon, color: color, size: 24),
              if (expanded)
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
