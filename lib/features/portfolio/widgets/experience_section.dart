import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_header.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Work Experience'),
          const SizedBox(height: 40),
          FadeInOnScroll(
            child: _ExperienceCard(
              role: 'Flutter Developer',
              company: 'Maxcore Technologies',
              location: 'Multan, Pakistan',
              duration: '02/2024 – Present',
              responsibilities: const [
                'I develop and maintain cross-platform Flutter applications for Android and iOS, focusing on high performance and clean code architecture. To support these applications, I integrate a robust suite of Firebase services—including Firestore, Realtime Database, Authentication, and Cloud Functions—to enable seamless real-time data synchronization and efficient serverless backend logic. On the networking side, I design and consume RESTful APIs using Dio and Retrofit, implementing structured error handling, advanced request interceptors, and automatic token refresh workflows to maximize application security and reliability.',
                'To ensure long-term code maintainability and enable full unit test coverage across all projects, I strictly apply a layered architecture consisting of Data, Domain, and Presentation layers alongside the MVVM design pattern. Additionally, I manage the end-to-end deployment lifecycle by handling code signing, configuring release builds, and successfully publishing applications to both the Google Play Console and App Store Connect.',
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> responsibilities;

  const _ExperienceCard({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.responsibilities,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
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
              width: double.infinity,
              padding: const EdgeInsets.all(32),
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
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 600;
                      if (isMobile) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.role,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildCompanyLocation(context),
                            const SizedBox(height: 16),
                            _buildDurationBadge(context),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.role,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildCompanyLocation(context),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          _buildDurationBadge(context),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  ...widget.responsibilities.map(
                    (resp) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 16),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryColor.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: primaryColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              resp,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildCompanyLocation(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.business_rounded, size: 18, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              widget.company,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_rounded, size: 18, color: primaryColor.withValues(alpha: 0.7)),
            const SizedBox(width: 6),
            Text(
              widget.location,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_month_rounded,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            widget.duration,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
