import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_durations.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';

class Navbar extends StatefulWidget {
  final Function(int) onNavTap;
  final ScrollController scrollController;

  const Navbar({
    super.key,
    required this.onNavTap,
    required this.scrollController,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isScrolled = false;
  int _hoveredIndex = -1;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: AppDurations.medium,
      height: AppSpacing.navbarHeight,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.background.withValues(alpha: 0.9)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
      ),
      child: Row(
        children: [
          _buildLogo(),
          const Spacer(),
          if (isMobile)
            _buildMobileMenuButton()
          else
            _buildDesktopNav(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          PortfolioData.logoImage,
          height: 36,
          errorBuilder: (_, __, ___) => Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'FA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'Fatma.',
          style: AppTypography.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < navItems.length; i++) ...[
          _NavItem(
            label: navItems[i],
            isHovered: _hoveredIndex == i,
            onHover: (hovered) => setState(() => _hoveredIndex = hovered ? i : -1),
            onTap: () => widget.onNavTap(i),
          ),
          if (i < navItems.length - 1) const SizedBox(width: AppSpacing.xs),
        ],
        const SizedBox(width: AppSpacing.md),
        _buildResumeButton(),
      ],
    );
  }

  Widget _buildResumeButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        onPressed: () => widget.onNavTap(navItems.length - 1),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          side: const BorderSide(color: AppColors.accent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Let\'s Talk',
          style: TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return IconButton(
      onPressed: () {
        setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);
        _showMobileMenu(context);
      },
      icon: Icon(
        _isMobileMenuOpen ? Icons.close : Icons.menu_rounded,
        color: AppColors.textPrimary,
        size: 26,
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (int i = 0; i < navItems.length; i++)
              ListTile(
                onTap: () {
                  Navigator.pop(ctx);
                  setState(() => _isMobileMenuOpen = false);
                  widget.onNavTap(i);
                },
                title: Text(
                  navItems[i],
                  style: AppTypography.headlineSmall.copyWith(fontSize: 16),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.textTertiary,
                ),
              ),
          ],
        ),
      ),
    ).whenComplete(() {
      if (mounted) setState(() => _isMobileMenuOpen = false);
    });
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final bool isHovered;
  final ValueChanged<bool> onHover;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isHovered,
    required this.onHover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: AppTypography.navLink.copyWith(
              color: isHovered ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
