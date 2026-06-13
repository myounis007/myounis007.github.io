import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Frontend & Mobile',
        'icon': Icons.phone_android_rounded,
        'skills': [
          {'name': 'Flutter & Dart', 'level': 0.95},
          {'name': 'State Management', 'level': 0.92},
          {'name': 'UI/UX & Animations', 'level': 0.90},
        ],
      },
      {
        'title': 'Backend & Cloud',
        'icon': Icons.cloud_done_outlined,
        'skills': [
          {'name': 'Firebase & Supabase', 'level': 0.88},
          {'name': 'REST & GraphQL', 'level': 0.85},
          {'name': 'Local Storage', 'level': 0.90},
        ],
      },
      {
        'title': 'Architecture & Tools',
        'icon': Icons.architecture_rounded,
        'skills': [
          {'name': 'Clean Arch & DI', 'level': 0.90},
          {'name': 'MVVM, MVC, Repo Pattern', 'level': 0.85},
          {'name': 'Git, CI/CD & Fastlane', 'level': 0.80},
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Technical Expertise'),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 900;
              Widget flexLayout = Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: categories.map((category) {
                  final card = _CategoryCard(category: category);
                  return isDesktop
                      ? Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              // Add spacing between cards on desktop
                              left: category == categories.first ? 0 : 16,
                              right: category == categories.last ? 0 : 16,
                            ),
                            child: card,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: card,
                        );
                }).toList(),
              );

              return isDesktop
                  ? IntrinsicHeight(child: flexLayout)
                  : flexLayout;
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final Map<String, dynamic> category;

  const _CategoryCard({required this.category});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -12.0 : 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(
                  alpha: _isHovered ? 0.3 : 0.15,
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: _isHovered
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.6)
                      : Colors.white.withValues(alpha: 0.05),
                  width: 1.5,
                ),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.15),
                      blurRadius: 50,
                      spreadRadius: 10,
                    ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.category['icon'],
                      color: Theme.of(context).primaryColor,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.category['title'],
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ...((widget.category['skills'] as List).map((skill) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: _SkillRow(
                        name: skill['name'],
                        level: skill['level'],
                      ),
                    );
                  })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final String name;
  final double level;

  const _SkillRow({required this.name, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.9),
              ),
            ),
            Text(
              '${(level * 100).toInt()}%',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Stack(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: level),
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOutQuart,
              builder: (context, value, child) {
                return FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
