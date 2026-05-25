import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_durations.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../core/animations/fade_in_animation.dart';
import '../../data/portfolio_data.dart';
import '../widgets/gradient_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreProjects;
  final VoidCallback onLetsTalk;

  const HeroSection({
    super.key,
    required this.onExploreProjects,
    required this.onLetsTalk,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xxl,
        vertical: isMobile ? AppSpacing.xxl : AppSpacing.sectionLarge,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: isMobile || isTablet
              ? _buildMobileLayout(context, screenWidth)
              : _buildDesktopLayout(context, screenWidth),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _buildHeroContent(context, false),
        ),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(
          flex: 2,
          child: _buildHeroImage(context, screenWidth * 0.28),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth) {
    return Column(
      children: [
        _buildHeroImage(context, screenWidth * 0.5),
        const SizedBox(height: AppSpacing.xl),
        _buildHeroContent(context, true),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInAnimation(
          delay: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              PortfolioData.role,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.accent,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        FadeInAnimation(
          delay: const Duration(milliseconds: 400),
          child: GradientText(
            text: PortfolioData.heroSubtitle,
            style: isMobile
                ? AppTypography.displaySmall
                : AppTypography.displayLarge,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        FadeInAnimation(
          delay: const Duration(milliseconds: 600),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              PortfolioData.heroDescription,
              style: AppTypography.bodyLarge,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        FadeInAnimation(
          delay: const Duration(milliseconds: 800),
          child: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              _HeroButton(
                label: 'Explore My Projects',
                isPrimary: true,
                onTap: onExploreProjects,
              ),
              _HeroButton(
                label: 'Preview CV',
                isPrimary: false,
                onTap: () => openUrl(PortfolioData.cvUrl),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        FadeInAnimation(
          delay: const Duration(milliseconds: 1000),
          child: _buildSocialRow(),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, double size) {
    return FadeInAnimation(
      delay: const Duration(milliseconds: 600),
      direction: SlideDirection.fromRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: size, maxHeight: size),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.accentGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.2),
              blurRadius: 60,
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            PortfolioData.profileImage,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(
              Icons.person,
              size: size * 0.5,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialRow() {
    const socialLinks = [
      {'icon': Icons.code, 'url': PortfolioData.githubUrl},
      {'icon': Icons.business_center, 'url': PortfolioData.linkedinUrl},
      {'icon': Icons.email_outlined, 'url': PortfolioData.emailUrl},
      {'icon': Icons.send, 'url': PortfolioData.telegramUrl},
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 1,
          color: AppColors.border,
        ),
        const SizedBox(width: AppSpacing.md),
        for (final link in socialLinks)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _SocialIcon(
              icon: link['icon'] as IconData,
              url: link['url'] as String,
            ),
          ),
      ],
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? AppColors.accentGradient : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered ? AppColors.accent : AppColors.border,
                    width: 1.5,
                  ),
            boxShadow: _isHovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: AppTypography.button.copyWith(
              color: widget.isPrimary
                  ? Colors.white
                  : (_isHovered ? AppColors.accent : AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.15)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: _isHovered ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
