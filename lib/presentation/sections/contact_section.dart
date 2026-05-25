import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_durations.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../core/animations/fade_in_animation.dart';
import '../../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding:
          isMobile ? AppSpacing.sectionPaddingMobile : AppSpacing.sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              const SectionHeader(
                label: 'Contact',
                title: 'Get In Touch',
                subtitle:
                    'Have a project in mind or want to discuss potential '
                    'opportunities? Feel free to reach out through any of the '
                    'channels below.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ScrollFadeIn(
            direction: SlideDirection.fromLeft,
            child: _buildContactForm(),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          flex: 2,
          child: ScrollFadeIn(
            direction: SlideDirection.fromRight,
            child: _buildContactInfo(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        ScrollFadeIn(child: _buildContactInfo()),
        const SizedBox(height: AppSpacing.lg),
        ScrollFadeIn(child: _buildContactForm()),
      ],
    );
  }

  Widget _buildContactForm() {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Let's Build Something Great", style: AppTypography.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Whether you have a specific project in mind or just want to say hi, '
            "my inbox is always open.",
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildTextField('Your Name')),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildTextField('Your Email')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTextField('Message', maxLines: 5),
          const SizedBox(height: AppSpacing.lg),
          _SendButton(),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textTertiary,
        ),
        filled: true,
        fillColor: AppColors.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Social Connect', style: AppTypography.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Usually responds within 24 hours.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              const _ContactLink(
                icon: Icons.email_outlined,
                label: PortfolioData.email,
                url: PortfolioData.emailUrl,
              ),
              const SizedBox(height: AppSpacing.md),
              const _ContactLink(
                icon: Icons.code,
                label: 'GitHub',
                url: PortfolioData.githubUrl,
              ),
              const SizedBox(height: AppSpacing.md),
              const _ContactLink(
                icon: Icons.business_center_outlined,
                label: 'LinkedIn',
                url: PortfolioData.linkedinUrl,
              ),
              const SizedBox(height: AppSpacing.md),
              const _ContactLink(
                icon: Icons.send_outlined,
                label: 'Telegram',
                url: PortfolioData.telegramUrl,
              ),
              const SizedBox(height: AppSpacing.md),
              const _ContactLink(
                icon: Icons.facebook_outlined,
                label: 'Facebook',
                url: PortfolioData.facebookUrl,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
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
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.08)
                : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? AppColors.accent.withValues(alpha: 0.3) : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  widget.label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: _isHovered ? AppColors.accent : AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: _isHovered ? AppColors.accent : AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Send Message',
                style: AppTypography.button.copyWith(color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.send, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
