import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/fade_in_on_scroll.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    final content = Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Available for projects pill
        FadeInOnScroll(
          delay: 0.1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF10B981),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Available for freelance projects",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        FadeInOnScroll(
          delay: 0.2,
          child: Text(
            "Hi, my name is",
            style: GoogleFonts.spaceGrotesk(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeInOnScroll(
          delay: 0.3,
          child: Text(
            "Muhammad Younis.",
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: isDesktop ? 44 : 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 8),
        FadeInOnScroll(
          delay: 0.4,
          child: SizedBox(
            height: isDesktop ? 90 : 110,
            child: DefaultTextStyle(
              style: GoogleFonts.spaceGrotesk(
                fontSize: isDesktop ? 36 : 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
                height: 1.2,
              ),
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Engineering experiences, not just apps.',
                    speed: const Duration(milliseconds: 70),
                  ),
                  TypewriterAnimatedText(
                    'Turning Figma frames into fluid reality.',
                    speed: const Duration(milliseconds: 70),
                  ),
                  TypewriterAnimatedText(
                    'Dart-powered. Design-obsessed.',
                    speed: const Duration(milliseconds: 70),
                  ),
                ],
                repeatForever: true,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInOnScroll(
          delay: 0.5,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Building highly responsive, scalable, and performant mobile, web, and desktop applications using Flutter and Dart. I focus on clean architecture and premium user interfaces.",
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.6,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        FadeInOnScroll(
          delay: 0.6,
          child: Wrap(
            alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
            spacing: 20,
            runSpacing: 16,
            children: [
              _PrimaryButton(
                text: 'Download CV',
                icon: Icons.download_rounded,
                onPressed: () => launchUrl(Uri.parse('Muhammad_Younis_Resume.pdf')),
              ),
              _SecondaryButton(
                text: 'GitHub',
                icon: Icons.code_rounded, // Optional, could just be text
                onPressed: () =>
                    launchUrl(Uri.parse('https://github.com/myounis007')),
              ),
            ],
          ),
        ),
      ],
    );

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ), // consistent with other sections
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: content),
            const SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: FadeInOnScroll(
                delay: 0.3,
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Ambient Glow
                        Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.4),
                                blurRadius: 100,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        // Outer Frosted Glass Ring
                        ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                            child: Container(
                              width: 380,
                              height: 380,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Inner Image Container
                        Container(
                          width: 340,
                          height: 340,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.6),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/portfoliopic.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          FadeInOnScroll(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.4),
                          blurRadius: 80,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.1),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.6),
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/portfoliopic.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          content,
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).primaryColor.withValues(alpha: _isHovered ? 0.6 : 0.3),
                blurRadius: _isHovered ? 20 : 10,
                spreadRadius: _isHovered ? 2 : 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: _isHovered ? 0.2 : 0),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.onSurface,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.text,
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
