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

class _ExperienceCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$company | $location',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 32, left: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  duration,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...responsibilities.map(
            (resp) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      resp,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
