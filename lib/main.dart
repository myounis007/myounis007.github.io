import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const PortfolioApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          title: 'Muhammad Younis - Senior Flutter Developer',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          home: const LoadingScreen(),
        );
      },
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primaryColor = const Color(0xFF54C5F8); // Flutter Blue
    final bgColor = isDark ? const Color(0xFF0A192F) : const Color(0xFFF8FAFC);
    final surfaceColor = isDark ? const Color(0xFF112240) : const Color(0xFFFFFFFF);
    final textColor = isDark ? const Color(0xFFCCD6F6) : const Color(0xFF1E293B);

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: bgColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        primary: primaryColor,
        secondary: const Color(0xFF0175C2), // Dart Blue
        surface: surfaceColor,
        onSurface: textColor,
        background: bgColor,
        onBackground: textColor,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: brightness).textTheme,
      ).apply(bodyColor: textColor, displayColor: textColor),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller, curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PortfolioHome(),
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(
            opacity: anim,
            child: child,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const FlutterLogo(size: 150),
          ),
        ),
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
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
          // Background Widget Tree
          Positioned.fill(
            child: CustomPaint(
              painter: WidgetTreePainter(Theme.of(context).colorScheme),
            ),
          ),
          
          // Main Scrollable Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
                title: Row(
                  children: [
                    const FlutterLogo(size: 30),
                    const SizedBox(width: 12),
                    Text(
                      'Muhammad Younis',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                actions: isDesktop
                    ? [
                        _NavBtn(title: 'Home', onTap: () => _scrollTo(_homeKey)),
                        _NavBtn(title: 'Skills', onTap: () => _scrollTo(_skillsKey)),
                        _NavBtn(title: 'Projects', onTap: () => _scrollTo(_projectsKey)),
                        _NavBtn(title: 'Contact', onTap: () => _scrollTo(_contactKey)),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: Icon(themeNotifier.value == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode),
                          onPressed: () {
                            themeNotifier.value =
                                themeNotifier.value == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark;
                          },
                        ),
                        const SizedBox(width: 24),
                      ]
                    : [
                        IconButton(
                          icon: Icon(themeNotifier.value == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode),
                          onPressed: () {
                            themeNotifier.value =
                                themeNotifier.value == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark;
                          },
                        ),
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openEndDrawer(),
                          ),
                        ),
                      ],
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(key: _homeKey, height: 60),
                        const HeroSection(),
                        const SizedBox(height: 80),
                        const StatsSection(),
                        SizedBox(key: _skillsKey, height: 100),
                        const SkillsSection(),
                        SizedBox(key: _projectsKey, height: 100),
                        const ProjectsSection(),
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
        ],
      ),
      endDrawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const DrawerHeader(
                    child: FlutterLogo(size: 80),
                  ),
                  ListTile(
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_homeKey);
                      }),
                  ListTile(
                      title: const Text('Skills'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_skillsKey);
                      }),
                  ListTile(
                      title: const Text('Projects'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_projectsKey);
                      }),
                  ListTile(
                      title: const Text('Contact'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_contactKey);
                      }),
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

// ---------------------------------------------------------
// HERO SECTION
// ---------------------------------------------------------

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    final content = Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          "Hi, my name is",
          style: GoogleFonts.spaceGrotesk(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Muhammad Younis.",
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isDesktop ? 64 : 48,
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Crafting pixel-perfect cross-platform apps.",
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isDesktop ? 48 : 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "I'm a Senior Flutter Developer based in Multan, Pakistan with over 2 years of experience. I specialize in building highly responsive, beautiful, and performant mobile, web, and desktop applications using Flutter and Dart.",
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                'Download CV',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                launchUrl(Uri.parse('https://github.com/myounis007'));
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'GitHub',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          children: [
            Expanded(flex: 3, child: content),
            Expanded(
              flex: 2,
              child: FadeInOnScroll(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 4),
                    image: const DecorationImage(
                      image: AssetImage('assets/portfoliopic.png'), // Keep if exists, otherwise fallback
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FlutterLogo(size: 200, style: FlutterLogoStyle.markOnly),
                  ), // Fallback if image fails
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: content,
    );
  }
}

// ---------------------------------------------------------
// STATS SECTION
// ---------------------------------------------------------

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInOnScroll(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 40,
          runSpacing: 40,
          children: const [
            _StatCounter(end: 12, title: 'Apps Published', suffix: '+'),
            _StatCounter(end: 2, title: 'Years Experience', suffix: '+'),
            _StatCounter(end: 50, title: 'Happy Clients', suffix: '+'),
            _StatCounter(end: 100, title: 'GitHub Stars', suffix: '+'),
            _StatCounter(end: 15, title: 'Countries Reached', suffix: ''),
          ],
        ),
      ),
    );
  }
}

class _StatCounter extends StatelessWidget {
  final int end;
  final String title;
  final String suffix;

  const _StatCounter({required this.end, required this.title, required this.suffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: end),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return Text(
              '$value$suffix',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// SKILLS SECTION
// ---------------------------------------------------------

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: 'Technical Skills'),
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
                  _SkillBar(name: 'Dart (Null Safety, Streams, Isolates)', level: 0.90),
                  _SkillBar(name: 'State Management (Riverpod, GetX, BLoC)', level: 0.92),
                  _SkillBar(name: 'Backend & Data (Firebase, REST, GraphQL)', level: 0.85),
                  _SkillBar(name: 'Local Storage (Hive, Isar, SQLite)', level: 0.88),
                  _SkillBar(name: 'Animations (Implicit, Rive, Lottie)', level: 0.80),
                  _SkillBar(name: 'UI/UX (Responsive, Platform Channels)', level: 0.95),
                  _SkillBar(name: 'DevOps & CI/CD (GitHub Actions, Fastlane)', level: 0.75),
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
            color: Theme.of(context).primaryColor.withOpacity(0.1),
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

// ---------------------------------------------------------
// PROJECTS SECTION
// ---------------------------------------------------------

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
      'description': 'A web-responsive document & project management tool with professional desktop-first standards.',
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
      'description': 'A comprehensive pregnancy tracking app with offline fallback and real-time backend synchronization.',
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
      'description': 'A modern prompt engine interface featuring a futuristic glassmorphic design and cyber-iridescent elements.',
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
      'description': 'Connect with people nearby who share your interests using powerful location-based matching.',
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
      'description': 'A robust prompt generation tool utilizing advanced state management and clean architecture patterns.',
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
      'description': 'An innovative e-commerce/booking platform with highly responsive UI and smooth transitions.',
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
      'description': 'Modern mental health and wellness tracker with soothing UI and lottie animations.',
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
      'description': 'A dedicated delivery and service partner application with real-time route tracking.',
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
      'description': 'A fast, user-friendly food delivery application with seamless payment integration.',
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
          _SectionHeader(title: 'Featured Projects'),
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
                    color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                  crossAxisCount: isDesktop ? 3 : (constraints.maxWidth > 600 ? 2 : 1),
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
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mockup Area
              Expanded(
                flex: 3,
                child: Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
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
              // Content Area
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
                                  onTap: () => launchUrl(Uri.parse(widget.project['github'])),
                                  child: const FaIcon(FontAwesomeIcons.github, size: 20),
                                ),
                              const SizedBox(width: 12),
                              if (widget.project['demo'].isNotEmpty)
                                InkWell(
                                  onTap: () => launchUrl(Uri.parse(widget.project['demo'])),
                                  child: const FaIcon(FontAwesomeIcons.externalLinkAlt, size: 18),
                                ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project['description'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
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

// ---------------------------------------------------------
// CONTACT SECTION
// ---------------------------------------------------------

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _SectionHeader(title: 'Get In Touch', center: true),
          const SizedBox(height: 24),
          Text(
            "Although I'm currently looking for new opportunities, my inbox is always open. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              return Center(
                child: Container(
                  width: isDesktop ? 600 : double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTextField(context, 'Name'),
                      const SizedBox(height: 24),
                      _buildTextField(context, 'Email'),
                      const SizedBox(height: 24),
                      _buildTextField(context, 'Message', maxLines: 5),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Say Hello',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}

// ---------------------------------------------------------
// FOOTER
// ---------------------------------------------------------

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/myounis007'),
              _SocialIcon(icon: FontAwesomeIcons.linkedin, url: 'https://linkedin.com/in/'),
              _SocialIcon(icon: FontAwesomeIcons.twitter, url: 'https://twitter.com/'),
              _SocialIcon(icon: FontAwesomeIcons.upwork, url: 'https://upwork.com/'),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Designed & Built by Muhammad Younis',
            style: GoogleFonts.spaceGrotesk(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter Web',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final FaIconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        icon: FaIcon(icon),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        hoverColor: Theme.of(context).primaryColor,
        onPressed: () => launchUrl(Uri.parse(url)),
      ),
    );
  }
}

// ---------------------------------------------------------
// UTILITIES & COMPONENTS
// ---------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool center;

  const _SectionHeader({required this.title, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (center)
          Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
        if (center) const SizedBox(width: 24),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 24),
        if (!center)
          Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
        if (center)
          Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
      ],
    );
  }
}

class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final double delay;

  const FadeInOnScroll({super.key, required this.child, this.delay = 0});

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

class _FadeInOnScrollState extends State<FadeInOnScroll> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class WidgetTreePainter extends CustomPainter {
  final ColorScheme colorScheme;
  WidgetTreePainter(this.colorScheme);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = colorScheme.onSurface.withOpacity(0.02)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double nodeSize = 40;
    
    // Draw some random widget tree nodes in the background
    void drawNode(double x, double y) {
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(x, y), width: nodeSize, height: nodeSize), const Radius.circular(8)), paint);
    }

    void drawLine(Offset start, Offset end) {
      canvas.drawLine(start, end, paint);
    }

    // Top left cluster
    drawNode(100, 150);
    drawNode(50, 250);
    drawNode(150, 250);
    drawLine(const Offset(100, 170), const Offset(50, 230));
    drawLine(const Offset(100, 170), const Offset(150, 230));

    // Bottom right cluster
    final w = size.width;
    final h = size.height;
    if (w > 400 && h > 400) {
      drawNode(w - 150, h - 300);
      drawNode(w - 200, h - 200);
      drawNode(w - 100, h - 200);
      drawNode(w - 250, h - 100);
      drawLine(Offset(w - 150, h - 280), Offset(w - 200, h - 220));
      drawLine(Offset(w - 150, h - 280), Offset(w - 100, h - 220));
      drawLine(Offset(w - 200, h - 180), Offset(w - 250, h - 120));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
