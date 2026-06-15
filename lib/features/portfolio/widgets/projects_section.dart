import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_header.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Mobile', 'Web', 'Cross-platform'];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Papyrus',
      'category': 'Web',
      'description':
          'A web-responsive document & project management tool with professional desktop-first standards.',
      'stack': 'Flutter Web, GoRouter, Riverpod',
      'targets': 'Web, Desktop',
      'features': 'Professional UI, Sidebar Navigation, Review Queue',
      'architecture': 'Riverpod MVC',
      'github': 'https://github.com',
      'demo': 'https://demo.com',
    },
    {
      'title': 'FloHealthyApp',
      'category': 'Mobile',
      'description':
          'A comprehensive pregnancy tracking app with offline fallback and real-time backend synchronization.',
      'stack': 'Flutter 3.x, SQLite/Hive, REST APIs',
      'targets': 'Android, iOS',
      'features': 'Offline Fallback, Weekly Milestones, Period Tracking',
      'architecture': 'Repository Pattern',
      'github': 'https://github.com',
      'demo': '',
    },
    {
      'title': 'ZePrompt',
      'category': 'Cross-platform',
      'description':
          'A modern prompt engine interface featuring a futuristic glassmorphic design and cyber-iridescent elements.',
      'stack': 'Flutter, Custom Animations, Provider',
      'targets': 'Android, Web, Desktop',
      'features': 'Glassmorphic UI, Prompt Handling, Dark Mode',
      'architecture': 'Clean Architecture',
      'github': 'https://github.com',
      'demo': 'https://demo.com',
    },
    {
      'title': 'Clustivo',
      'category': 'Mobile',
      'description':
          'Connect with people nearby who share your interests using powerful location-based matching.',
      'stack': 'Flutter, Firebase, Google Maps',
      'targets': 'Android, iOS',
      'features': 'Geolocator, Real-time Chat, Map Integration',
      'architecture': 'BLoC',
      'github': 'https://github.com',
      'demo': '',
    },
    {
      'title': 'PromptEngine',
      'category': 'Web',
      'description':
          'A robust prompt generation tool utilizing advanced state management and clean architecture patterns.',
      'stack': 'Flutter, BLoC/Cubit, TDD',
      'targets': 'Web',
      'features': 'Clean Architecture, Robust Controller Logic',
      'architecture': 'Clean Architecture',
      'github': 'https://github.com',
      'demo': 'https://demo.com',
    },
    {
      'title': 'Mekaaz',
      'category': 'Cross-platform',
      'description':
          'An innovative e-commerce/booking platform with highly responsive UI and smooth transitions.',
      'stack': 'Flutter, Firebase, REST APIs',
      'targets': 'Android, iOS, Web',
      'features': 'Shopping Cart, Payment Gateway, Admin Dashboard',
      'architecture': 'MVVM',
      'github': 'https://github.com',
      'demo': '',
    },
    {
      'title': 'Luna',
      'category': 'Mobile',
      'description':
          'Modern mental health and wellness tracker with soothing UI and lottie animations.',
      'stack': 'Flutter, Lottie, Provider',
      'targets': 'Android, iOS',
      'features': 'Mood Tracking, Journaling, Reminders',
      'architecture': 'MVC',
      'github': 'https://github.com',
      'demo': '',
    },
    {
      'title': 'Doorstep Partner',
      'category': 'Mobile',
      'description':
          'A dedicated delivery and service partner application with real-time route tracking.',
      'stack': 'Flutter, Google Maps, WebSockets',
      'targets': 'Android',
      'features': 'Live Tracking, Push Notifications, Earnings Dashboard',
      'architecture': 'BLoC',
      'github': 'https://github.com',
      'demo': '',
    },
    {
      'title': 'Food Delivery',
      'category': 'Mobile',
      'description':
          'A fast, user-friendly food delivery application with seamless payment integration.',
      'stack': 'Flutter, Stripe, GetX',
      'targets': 'Android, iOS',
      'features': 'Restaurant Browsing, Cart, Stripe Checkout',
      'architecture': 'GetX Pattern',
      'github': 'https://github.com',
      'demo': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _selectedCategory == 'All'
        ? _projects
        : _projects.where((p) => p['category'] == _selectedCategory).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return Theme(
                data: Theme.of(
                  context,
                ).copyWith(canvasColor: Colors.transparent),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: GoogleFonts.inter(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: 0.2),
                  elevation: isSelected ? 8 : 0,
                  shadowColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop
                      ? 3
                      : (constraints.maxWidth > 600 ? 2 : 1),
                  childAspectRatio: 1.05,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  return FadeInOnScroll(
                    delay: index * 0.1,
                    child: _ProjectCard(project: filteredProjects[index]),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
        transform: Matrix4.translationValues(
          0.0,
          _isHovered ? -10.0 : 0.0,
          0.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
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
                  BoxShadow(
                    color: primaryColor.withValues(
                      alpha: _isHovered ? 0.15 : 0.0,
                    ),
                    blurRadius: 30,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image/Icon Header area
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        // Abstract glow
                        Positioned(
                          top: -20,
                          right: -20,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: _isHovered ? 100 : 70,
                            height: _isHovered ? 100 : 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withValues(alpha: 0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.4),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: AnimatedScale(
                            scale: _isHovered ? 1.1 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Icon(
                              widget.project['category'] == 'Mobile'
                                  ? Icons.phone_android_rounded
                                  : widget.project['category'] == 'Web'
                                  ? Icons.web_rounded
                                  : Icons.devices_rounded,
                              size: 56,
                              color: primaryColor.withValues(
                                alpha: _isHovered ? 1.0 : 0.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content area
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.project['title'],
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  if (widget.project['github'].isNotEmpty)
                                    InkWell(
                                      onTap: () => launchUrl(
                                        Uri.parse(widget.project['github']),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.github,
                                        size: 20,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.7),
                                      ),
                                    ),
                                  const SizedBox(width: 16),
                                  if (widget.project['demo'].isNotEmpty)
                                    InkWell(
                                      onTap: () => launchUrl(
                                        Uri.parse(widget.project['demo']),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.upRightFromSquare,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Text(
                              widget.project['description'],
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                height: 1.5,
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: primaryColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              widget.project['stack'],
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
}
