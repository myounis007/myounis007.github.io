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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
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
        const SizedBox(height: 32),
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
        SizedBox(
          height: isDesktop ? 120 : 120,
          child: DefaultTextStyle(
            style: GoogleFonts.spaceGrotesk(
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
              height: 1.1,
            ),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Engineering experiences, not just apps.',
                  speed: const Duration(milliseconds: 80),
                ),
                TypewriterAnimatedText(
                  'Turning Figma frames into fluid reality.',
                  speed: const Duration(milliseconds: 80),
                ),

                TypewriterAnimatedText(
                  'Dart-powered. Design-obsessed.',
                  speed: const Duration(milliseconds: 80),
                ),
              ],
              repeatForever: true,
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Building highly responsive, scalable, and performant mobile, web, and desktop applications using Flutter and Dart.",
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse('Muhammad_Younis_Cv.pdf'));
              },
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text(
                'Download CV',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () {
                launchUrl(Uri.parse('https://github.com/myounis007'));
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background Ambient Glow
                        Container(
                          width: 340,
                          height: 340,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.5),
                                blurRadius: 100,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        // Outer Frosted Glass Ring
                        ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                            child: Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Inner Image Container
                        Container(
                          width: 360,
                          height: 360,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.8),
                              width: 3,
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
