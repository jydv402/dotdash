import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:morse_web_play/main.dart';
import 'package:url_launcher/url_launcher.dart';

/// A widget that displays the brand name and a link to the GitHub repository.
class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future<void> launchLink() async {
      if (!await launchUrl(Consts.projectUrl)) {
        throw Exception('Could not launch ${Consts.projectUrl}');
      }
    }

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Spacer(),
          Text("DotDash", style: GoogleFonts.nabla(fontSize: 36)),
          const Spacer(),
          InkWell(
            onTap: launchLink,
            borderRadius: BorderRadius.circular(12),
            child: Iconify(
              Ph.github_logo_duotone,
              size: 28,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
