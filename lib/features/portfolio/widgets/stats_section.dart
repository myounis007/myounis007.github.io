import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _PremiumStatCard(
            end: 10,
            title: 'Apps Published',
            suffix: '+',
            icon: FontAwesomeIcons.googlePlay,
          ),
          SizedBox(height: 20),
          _PremiumStatCard(
            end: 2,
            title: 'Years Experience',
            suffix: '+',
            icon: FontAwesomeIcons.laptopCode,
          ),
          SizedBox(height: 20),
          _PremiumStatCard(
            end: 8,
            title: 'Happy Clients',
            suffix: '+',
            icon: FontAwesomeIcons.handshake,
          ),
        ],
      ),
    );
  }
}

class _PremiumStatCard extends StatefulWidget {
  final int end;
  final String title;
  final String suffix;
  final dynamic icon;

  const _PremiumStatCard({
    required this.end,
    required this.title,
    required this.suffix,
    required this.icon,
  });

  @override
  State<_PremiumStatCard> createState() => _PremiumStatCardState();
}

class _PremiumStatCardState extends State<_PremiumStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: _isHovered ? 0.3 : 0.2),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? primaryColor.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: _isHovered ? 0.15 : 0.0),
                  blurRadius: _isHovered ? 30 : 0,
                  spreadRadius: _isHovered ? 0 : 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(
                    widget.icon,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<int>(
                        tween: IntTween(begin: 0, end: widget.end),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, child) {
                          return Text(
                            '$value${widget.suffix}',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              height: 1.0,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.translationValues(_isHovered ? 0 : -10, 0, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: primaryColor.withValues(alpha: 0.5),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
