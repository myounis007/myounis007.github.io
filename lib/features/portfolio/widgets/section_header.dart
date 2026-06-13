import 'package:flutter/material.dart';


class SectionHeader extends StatelessWidget {
  final String title;
  final bool center;

  const SectionHeader({super.key, required this.title, this.center = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        if (center)
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
        if (center) const SizedBox(width: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(width: 24),
        if (!center)
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
        if (center)
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
      ],
    );
  }
}
