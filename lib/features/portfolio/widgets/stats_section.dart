import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInOnScroll(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                  blurRadius: 30,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: _StatCounter(
                        end: 10,
                        title: 'Apps Published',
                        suffix: '+',
                      ),
                    ),
                    Expanded(
                      child: _StatCounter(
                        end: 2,
                        title: 'Years Experience',
                        suffix: '+',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: _StatCounter(
                        end: 8,
                        title: 'Happy Clients',
                        suffix: '+',
                      ),
                    ),
                    // Expanded(child: _StatCounter(end: 100, title: 'GitHub Stars', suffix: '+')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCounter extends StatelessWidget {
  final int end;
  final String title;
  final String suffix;

  const _StatCounter({
    required this.end,
    required this.title,
    required this.suffix,
  });

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
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
