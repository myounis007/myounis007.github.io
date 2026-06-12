import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D14),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF7C4DFF),
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cyber Ambient Background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _AmbientBackgroundPainter(_animController.value),
                );
              },
            ),
          ),
          // Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      _buildHeaderSection(context),
                      const SizedBox(height: 100),
                      _buildSectionTitle('Projects'),
                      const SizedBox(height: 40),
                      _buildProjectsGrid(context),
                      const SizedBox(height: 100),
                      _buildSectionTitle('Get In Touch'),
                      const SizedBox(height: 40),
                      _buildFooter(context),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final content = [
      Expanded(
        flex: isDesktop ? 3 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, I'm",
              style: GoogleFonts.inter(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Flutter Developer.",
              style: GoogleFonts.outfit(
                fontSize: isDesktop ? 64 : 48,
                fontWeight: FontWeight.w900,
                height: 1.1,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      Colors.white,
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ).createShader(const Rect.fromLTWH(0, 0, 400, 100)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "I build premium, cross-platform experiences with Flutter.\nSpecializing in beautiful UI, smooth animations, and robust architecture.",
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                _CyberButton(
                  text: 'View GitHub',
                  onTap: () => launchUrl(Uri.parse('https://github.com')),
                  isPrimary: true,
                ),
                const SizedBox(width: 16),
                _CyberButton(
                  text: 'Contact Me',
                  onTap: () => launchUrl(Uri.parse('mailto:hello@example.com')),
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
      if (isDesktop) const SizedBox(width: 64),
      if (!isDesktop) const SizedBox(height: 48),
      Expanded(
        flex: isDesktop ? 2 : 0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 160,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
        ),
      ),
    ];

    return isDesktop
        ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: content)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: content,
          );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 2 : 1,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      childAspectRatio: 1.5,
      children: [
        _ProjectCard(
          title: 'Cyber Dashboard',
          description:
              'A dark-mode analytics dashboard built with Flutter Web.',
          tech: const ['Flutter', 'Riverpod', 'FlChart'],
          icon: FontAwesomeIcons.chartLine,
        ),
        _ProjectCard(
          title: 'Neon E-Commerce',
          description: 'Cross-platform shopping app with fluid animations.',
          tech: const ['Flutter', 'Firebase', 'Stripe'],
          icon: FontAwesomeIcons.cartShopping,
        ),
        _ProjectCard(
          title: 'Dev Companion',
          description:
              'A productivity tool for developers with local database.',
          tech: const ['Flutter Desktop', 'Isar', 'Provider'],
          icon: FontAwesomeIcons.code,
        ),
        _ProjectCard(
          title: 'Crypto Wallet UI',
          description: 'Premium glassmorphism UI for a crypto wallet.',
          tech: const ['Flutter', 'Animations'],
          icon: FontAwesomeIcons.wallet,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return _GlassContainer(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            "Let's Build Something Together",
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: 'https://github.com',
              ),
              const SizedBox(width: 24),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: 'https://linkedin.com',
              ),
              const SizedBox(width: 24),
              _SocialIcon(
                icon: FontAwesomeIcons.twitter,
                url: 'https://twitter.com',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "© ${DateTime.now().year} Built with Flutter Web & GitHub Pages",
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tech;
  final FaIconData icon;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.tech,
    required this.icon,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0),
        child: _GlassContainer(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(
                widget.icon,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Spacer(),
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.tech
                    .map(
                      (t) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          t,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CyberButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;

  const _CyberButton({
    required this.text,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: isPrimary
              ? LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                )
              : null,
          border: isPrimary
              ? null
              : Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                    blurRadius: 20,
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isPrimary ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final FaIconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : Colors.white.withOpacity(0.05),
            border: Border.all(
              color: isHovered
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: FaIcon(
            widget.icon,
            color: isHovered
                ? Theme.of(context).colorScheme.primary
                : Colors.white70,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const _GlassContainer({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AmbientBackgroundPainter extends CustomPainter {
  final double animation;

  _AmbientBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF7C4DFF).withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    final paint2 = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    canvas.drawCircle(
      Offset(size.width * 0.2 + (animation * 100), size.height * 0.3),
      300,
      paint1,
    );

    canvas.drawCircle(
      Offset(size.width * 0.8 - (animation * 100), size.height * 0.7),
      300,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
