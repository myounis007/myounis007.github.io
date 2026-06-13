import 'dart:ui';
import 'package:flutter/material.dart';
import 'section_header.dart';
import 'stats_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              return isDesktop
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 3, child: _buildAboutContainer(context)),
                          const SizedBox(width: 40),
                          const Expanded(flex: 2, child: StatsSection()),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        _buildAboutContainer(context),
                        const SizedBox(height: 48),
                        const StatsSection(),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContainer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello! My name is Muhammad Younis and I enjoy creating things that live on the internet. My interest in software development started back when I built my first Android app—turns out hacking together custom UI components taught me a lot about Flutter and modern frontend architecture!",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                "Fast-forward to today, and I've had the privilege of working on various freelance projects, building scalable backends, and crafting pixel-perfect interfaces. My main focus these days is building accessible, inclusive products and digital experiences that perform beautifully across all devices.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                "When I'm not at the computer writing code, I'm usually exploring new design trends, reading about clean architecture patterns, or constantly learning to stay at the cutting edge of the Flutter ecosystem.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
