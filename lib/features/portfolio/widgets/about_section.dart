import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'section_header.dart';
import 'stats_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              return isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 5, child: _PremiumAboutContainer()),
                        const SizedBox(width: 40),
                        const Expanded(flex: 4, child: StatsSection()),
                      ],
                    )
                  : const Column(
                      children: [
                        _PremiumAboutContainer(),
                        SizedBox(height: 48),
                        StatsSection(),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _PremiumAboutContainer extends StatefulWidget {
  const _PremiumAboutContainer();

  @override
  State<_PremiumAboutContainer> createState() => _PremiumAboutContainerState();
}

class _PremiumAboutContainerState extends State<_PremiumAboutContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: _isHovered ? 0.3 : 0.2),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: _isHovered
                    ? primaryColor.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: _isHovered ? 0.15 : 0.05),
                  blurRadius: _isHovered ? 40 : 30,
                  spreadRadius: _isHovered ? 0 : -5,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 0.1 : 0.05,
                    child: FaIcon(
                      FontAwesomeIcons.code,
                      size: 150,
                      color: primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRichText(
                      context,
                      [
                        const TextSpan(text: "Hello! My name is "),
                        TextSpan(
                          text: "Muhammad Younis",
                          style: GoogleFonts.spaceGrotesk(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const TextSpan(
                            text:
                                " and I enjoy creating things that live on the internet. My interest in software development started back when I built my first Android app—turns out hacking together custom UI components taught me a lot about "),
                        TextSpan(
                          text: "Flutter",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                            text: " and modern frontend architecture!"),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildRichText(
                      context,
                      [
                        const TextSpan(
                            text:
                                "Fast-forward to today, and I've had the privilege of working on various freelance projects, building "),
                        TextSpan(
                          text: "scalable backends",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: ", and crafting "),
                        TextSpan(
                          text: "pixel-perfect interfaces",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                            text:
                                ". My main focus these days is building accessible, inclusive products and digital experiences that perform beautifully across all devices."),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildRichText(
                      context,
                      [
                        const TextSpan(
                            text:
                                "When I'm not at the computer writing code, I'm usually exploring new "),
                        TextSpan(
                          text: "design trends",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: ", reading about "),
                        TextSpan(
                          text: "clean architecture patterns",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(
                            text:
                                ", or constantly learning to stay at the cutting edge of the Flutter ecosystem."),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichText(BuildContext context, List<InlineSpan> spans) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.8),
            ),
        children: spans,
      ),
    );
  }
}
