import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

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
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 4,
                    ),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/portfoliopic.png',
                      ), // Keep if exists, otherwise fallback
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
