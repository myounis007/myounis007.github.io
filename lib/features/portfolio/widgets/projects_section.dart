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
              return ChoiceChip(
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.surface,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
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
                  childAspectRatio: 0.85,
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.project['category'] == 'Mobile'
                            ? Icons.phone_android
                            : Icons.web,
                        size: 64,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                                  child: const FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 20,
                                  ),
                                ),
                              const SizedBox(width: 12),
                              if (widget.project['demo'].isNotEmpty)
                                InkWell(
                                  onTap: () => launchUrl(
                                    Uri.parse(widget.project['demo']),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.externalLinkAlt,
                                    size: 18,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project['description'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        widget.project['stack'],
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
