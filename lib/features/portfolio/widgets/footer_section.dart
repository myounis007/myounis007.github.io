import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: 'https://github.com/myounis007',
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: 'https://www.linkedin.com/in/muhammad-younis-b0ba83254?utm_source=share_via&utm_content=profile&utm_medium=member_android',
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.twitter,
                url: 'https://twitter.com/',
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.upwork,
                url: 'https://upwork.com/',
              ),
              _SocialIcon(
                icon: FontAwesomeIcons.whatsapp,
                url: 'https://wa.me/923453454707',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Designed & Built by Muhammad Younis',
            style: GoogleFonts.spaceGrotesk(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        hoverColor: Theme.of(context).primaryColor,
        onPressed: () => launchUrl(Uri.parse(url)),
      ),
    );
  }
}
