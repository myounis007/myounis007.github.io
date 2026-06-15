import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

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
      {
        'title': 'Advanced Features',
        'icon': Icons.extension_rounded,
        'skills': [
          {'name': 'AI Integrations', 'level': 0.85},
          {'name': 'Maps & Payments', 'level': 0.88},
          {'name': 'Push Notifications', 'level': 0.90},
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Technical Expertise'),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              
              if (isDesktop) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: FadeInOnScroll(delay: 0.1, child: _CategoryCard(category: categories[0]))),
                        const SizedBox(width: 24),
                        Expanded(child: FadeInOnScroll(delay: 0.2, child: _CategoryCard(category: categories[1]))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: FadeInOnScroll(delay: 0.3, child: _CategoryCard(category: categories[2]))),
                        const SizedBox(width: 24),
                        Expanded(child: FadeInOnScroll(delay: 0.4, child: _CategoryCard(category: categories[3]))),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: List.generate(categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FadeInOnScroll(
                        delay: index * 0.1,
                        child: _CategoryCard(category: categories[index]),
                      ),
                    );
                  }),
                );
              }
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
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
          0.0,
          _isHovered ? -8.0 : 0.0,
          0.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(
                  alpha: _isHovered ? 0.3 : 0.15,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered
                      ? primaryColor.withValues(alpha: 0.4)
                      : Colors.white.withValues(alpha: 0.05),
                  width: 1.5,
                ),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.category['icon'],
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.category['title'],
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ...((widget.category['skills'] as List).map((skill) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(level * 100).toInt()}%',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
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
              duration: const Duration(milliseconds: 1500),
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
                          ).primaryColor.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 0,
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
