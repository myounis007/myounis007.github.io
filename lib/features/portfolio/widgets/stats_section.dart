import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/fade_in_on_scroll.dart';

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
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
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
