import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_durations.dart';
import '../../core/utils/responsive.dart';
import '../../core/animations/fade_in_animation.dart';
import '../../data/portfolio_data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                label: 'Skills',
                title: 'Technical Ecosystem',
                subtitle:
                    'A specialized toolkit focused on building high-performance, '
                    'cross-platform mobile applications.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              const SizedBox(height: AppSpacing.xxl),
              _buildScrollingTechBar(),
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
            child: _buildMobileMastery(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              ScrollFadeIn(
                direction: SlideDirection.fromRight,
                child: _buildDevelopmentCore(),
              ),
              const SizedBox(height: AppSpacing.md),
              ScrollFadeIn(
                direction: SlideDirection.fromRight,
                child: _buildWorkflow(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        ScrollFadeIn(child: _buildMobileMastery()),
        const SizedBox(height: AppSpacing.md),
        ScrollFadeIn(child: _buildDevelopmentCore()),
        const SizedBox(height: AppSpacing.md),
        ScrollFadeIn(child: _buildWorkflow()),
      ],
    );
  }

  Widget _buildMobileMastery() {
    final topSkills = skills.where((s) => s.proficiency >= 0.8).toList();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.phone_android_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Text('Mobile Mastery', style: AppTypography.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Extensive experience in Flutter & Dart, building secure and fluid '
            'cross-platform applications with pixel-perfect UI.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final skill in topSkills) ...[
            _SkillProgressBar(
              name: skill.name,
              percentage: skill.proficiency,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }

  Widget _buildDevelopmentCore() {
    final coreSkills =
        skills.where((s) => s.proficiency < 0.8 && s.proficiency >= 0.6).toList();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.terminal_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Text('Development Core', style: AppTypography.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: coreSkills.map((s) => _SkillBadge(name: s.name)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflow() {
    const workflowItems = ['Git', 'CI/CD', 'Agile', 'Clean Architecture'];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_tree_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Text('Workflow', style: AppTypography.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: workflowItems.map((w) => _SkillBadge(name: w)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollingTechBar() {
    return ScrollFadeIn(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _InfiniteScrollRow(
            children: skills
                .map(
                  (s) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/3.png',
                          width: 20,
                          height: 20,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.code,
                            size: 20,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          s.name,
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _SkillProgressBar extends StatefulWidget {
  final String name;
  final double percentage;

  const _SkillProgressBar({
    required this.name,
    required this.percentage,
  });

  @override
  State<_SkillProgressBar> createState() => _SkillProgressBarState();
}

class _SkillProgressBarState extends State<_SkillProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _maybeAnimate() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _maybeAnimate();
    });

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.name, style: AppTypography.labelLarge),
                Text(
                  '${(_animation.value * 100).toInt()}%',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                widthFactor: _animation.value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String name;

  const _SkillBadge({required this.name});

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.accent.withValues(alpha: 0.15)
              : AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Text(
          widget.name,
          style: AppTypography.labelMedium.copyWith(
            color: _isHovered ? AppColors.accent : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _InfiniteScrollRow extends StatefulWidget {
  final List<Widget> children;

  const _InfiniteScrollRow({required this.children});

  @override
  State<_InfiniteScrollRow> createState() => _InfiniteScrollRowState();
}

class _InfiniteScrollRowState extends State<_InfiniteScrollRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0, 0.05, 0.95, 1],
              ).createShader(bounds),
              blendMode: BlendMode.dstIn,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                controller: ScrollController(
                  initialScrollOffset:
                      _controller.value * constraints.maxWidth,
                ),
                child: Row(
                  children: [
                    ...widget.children,
                    ...widget.children,
                    ...widget.children,
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
