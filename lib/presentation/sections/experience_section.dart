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

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding:
          isMobile ? AppSpacing.sectionPaddingMobile : AppSpacing.sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              const SectionHeader(
                label: 'Experience & Education',
                title: 'My Journey',
                subtitle:
                    'My professional journey, education, and growth in Flutter '
                    'development and related technologies.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
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
        Expanded(child: _buildExperienceColumn()),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: _buildEducationColumn()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildExperienceColumn(),
        const SizedBox(height: AppSpacing.xl),
        _buildEducationColumn(),
      ],
    );
  }

  Widget _buildExperienceColumn() {
    return ScrollFadeIn(
      direction: SlideDirection.fromLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumnHeader(Icons.work_outline_rounded, 'Work Experience'),
          const SizedBox(height: AppSpacing.lg),
          for (int i = 0; i < experiences.length; i++) ...[
            _ExperienceTimelineItem(
              experience: experiences[i],
              isLast: i == experiences.length - 1,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationColumn() {
    return ScrollFadeIn(
      direction: SlideDirection.fromRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColumnHeader(Icons.school_outlined, 'Education'),
          const SizedBox(height: AppSpacing.lg),
          for (int i = 0; i < educations.length; i++) ...[
            _EducationTimelineItem(
              education: educations[i],
              isLast: i == educations.length - 1,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildColumnHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(title, style: AppTypography.headlineMedium),
      ],
    );
  }
}

class _ExperienceTimelineItem extends StatelessWidget {
  final ExperienceData experience;
  final bool isLast;

  const _ExperienceTimelineItem({
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.accentGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.accent.withValues(alpha: 0.5),
                    AppColors.accent.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(experience.role, style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm + 2,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                experience.duration,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              experience.company,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(experience.description, style: AppTypography.bodyMedium),
            if (experience.achievements.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              _AchievementsList(achievements: experience.achievements),
            ],
          ],
        ),
      ),
    );
  }
}

class _AchievementsList extends StatefulWidget {
  final List<String> achievements;

  const _AchievementsList({required this.achievements});

  @override
  State<_AchievementsList> createState() => _AchievementsListState();
}

class _AchievementsListState extends State<_AchievementsList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                Text(
                  'Key Achievements',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                AnimatedRotation(
                  duration: AppDurations.fast,
                  turns: _isExpanded ? 0.25 : 0,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.achievements
                  .map(
                    (a) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSpacing.xs + 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.only(top: 7, right: 10),
                            decoration: const BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(a, style: AppTypography.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          crossFadeState:
              _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: AppDurations.medium,
        ),
      ],
    );
  }
}

class _EducationTimelineItem extends StatelessWidget {
  final EducationData education;
  final bool isLast;

  const _EducationTimelineItem({
    required this.education,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeline(),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
            border: Border.all(color: AppColors.accent, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.2),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              color: AppColors.border,
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(education.degree, style: AppTypography.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm + 2,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                education.duration,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              education.institution,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (education.detail != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(education.detail!, style: AppTypography.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
