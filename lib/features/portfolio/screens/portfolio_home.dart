import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widget_tree_painter.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';

import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/experience_section.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: WidgetTreePainter(Theme.of(context).colorScheme),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [

              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(key: _homeKey, height: 120),
                        const HeroSection(),
                        SizedBox(key: _aboutKey, height: 100),
                        const AboutSection(),
                        SizedBox(key: _skillsKey, height: 100),
                        const SkillsSection(),
                        SizedBox(key: _projectsKey, height: 100),
                        const ProjectsSection(),
                        SizedBox(key: _experienceKey, height: 100),
                        const ExperienceSection(),
                        SizedBox(key: _contactKey, height: 100),
                        const ContactSection(),
                        const SizedBox(height: 80),
                        const FooterSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: isDesktop
                          ? [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.laptopCode,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              _NavBtn(title: 'Home', onTap: () => _scrollTo(_homeKey)),
                              _NavBtn(title: 'About', onTap: () => _scrollTo(_aboutKey)),
                              _NavBtn(title: 'Skills', onTap: () => _scrollTo(_skillsKey)),
                              _NavBtn(title: 'Projects', onTap: () => _scrollTo(_projectsKey)),
                              _NavBtn(title: 'Experience', onTap: () => _scrollTo(_experienceKey)),
                              _NavBtn(title: 'Contact', onTap: () => _scrollTo(_contactKey)),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  themeNotifier.value == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                                  size: 20,
                                ),
                                onPressed: () {
                                  themeNotifier.value = themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                                },
                              ),
                            ]
                          : [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.laptopCode,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Portfolio',
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                icon: Icon(
                                  themeNotifier.value == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                                  size: 20,
                                ),
                                onPressed: () {
                                  themeNotifier.value = themeNotifier.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                                },
                              ),
                              Builder(
                                builder: (context) => IconButton(
                                  icon: const Icon(Icons.menu, size: 20),
                                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const DrawerHeader(child: FlutterLogo(size: 80)),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_homeKey);
                    },
                  ),
                  ListTile(
                    title: const Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_aboutKey);
                    },
                  ),
                  ListTile(
                    title: const Text('Skills'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_skillsKey);
                    },
                  ),
                  ListTile(
                    title: const Text('Projects'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_projectsKey);
                    },
                  ),
                  ListTile(
                    title: const Text('Experience'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_experienceKey);
                    },
                  ),
                  ListTile(
                    title: const Text('Contact'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(_contactKey);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBtn({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      child: Text(title),
    );
  }
}
