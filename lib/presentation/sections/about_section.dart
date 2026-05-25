import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/animations/fade_in_animation.dart';
import '../../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _featureIcons = {
    'code': Icons.code_rounded,
    'devices': Icons.devices_rounded,
    'speed': Icons.speed_rounded,
    'architecture': Icons.architecture_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: isMobile ? AppSpacing.sectionPaddingMobile : AppSpacing.sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              const SectionHeader(
                label: 'About Me',
                title: 'Who I Am',
                subtitle: 'A passionate Flutter developer dedicated to crafting beautiful mobile experiences.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              _buildFeatureCards(isMobile),
              const SizedBox(height: AppSpacing.xxl),
              _buildJourneySection(isMobile),
              const SizedBox(height: AppSpacing.xxl),
              _buildStatsRow(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCards(bool isMobile) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < PortfolioData.aboutFeatures.length; i++)
          ScrollFadeIn(
            direction: i.isEven ? SlideDirection.fromLeft : SlideDirection.fromRight,
            child: SizedBox(
              width: isMobile ? double.infinity : 260,
              child: _FeatureCard(
                icon: _featureIcons[PortfolioData.aboutFeatures[i]['icon']] ?? Icons.star,
                title: PortfolioData.aboutFeatures[i]['title']!,
                description: PortfolioData.aboutFeatures[i]['desc']!,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildJourneySection(bool isMobile) {
    return ScrollFadeIn(
      child: GlassCard(
        padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text(
                  'My Journey',
                  style: AppTypography.headlineMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              PortfolioData.aboutJourney,
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(bool isMobile) {
    return ScrollFadeIn(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < PortfolioData.stats.length; i++) ...[
            if (i > 0) ...[
              Container(
                width: 1,
                height: 60,
                color: AppColors.border,
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
                ),
              ),
            ],
            _StatItem(
              value: PortfolioData.stats[i]['value']!,
              label: PortfolioData.stats[i]['label']!,
              sub: PortfolioData.stats[i]['sub']!,
            ),
          ],
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: AppTypography.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          Text(description, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String sub;

  const _StatItem({
    required this.value,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.heroGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            value,
            style: AppTypography.displayMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTypography.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        Text(sub, style: AppTypography.bodySmall),
      ],
    );
  }
}
