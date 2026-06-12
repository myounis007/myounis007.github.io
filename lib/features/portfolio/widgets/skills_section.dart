import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Technical Skills'),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              final crossAxisCount = isDesktop ? 2 : 1;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 40,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 6 : 4,
                children: const [
                  _SkillBar(name: 'Flutter SDK (2.x, 3.x)', level: 0.95),
                  _SkillBar(
                    name: 'Dart (Null Safety, Streams, Isolates)',
                    level: 0.90,
                  ),
                  _SkillBar(
                    name: 'State Management (Riverpod, GetX, BLoC)',
                    level: 0.92,
                  ),
                  _SkillBar(
                    name: 'Backend & Data (Firebase, REST, GraphQL)',
                    level: 0.85,
                  ),
                  _SkillBar(
                    name: 'Local Storage (Hive, Isar, SQLite)',
                    level: 0.88,
                  ),
                  _SkillBar(
                    name: 'Animations (Implicit, Rive, Lottie)',
                    level: 0.80,
                  ),
                  _SkillBar(
                    name: 'UI/UX (Responsive, Platform Channels)',
                    level: 0.95,
                  ),
                  _SkillBar(
                    name: 'DevOps & CI/CD (GitHub Actions, Fastlane)',
                    level: 0.75,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  final String name;
  final double level;

  const _SkillBar({required this.name, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              '${(level * 100).toInt()}%',
              style: GoogleFonts.spaceGrotesk(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 10,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: level),
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
