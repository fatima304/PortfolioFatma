import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_durations.dart';
import '../data/portfolio_data.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(
    navItems.length,
    (_) => GlobalKey(),
  );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: AppDurations.scroll,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _buildBackground(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 70),
                HeroSection(
                  key: _sectionKeys[0],
                  onExploreProjects: () => _scrollToSection(2),
                  onLetsTalk: () => _scrollToSection(5),
                ),
                AboutSection(key: _sectionKeys[1]),
                ProjectsSection(key: _sectionKeys[2]),
                SkillsSection(key: _sectionKeys[3]),
                ExperienceSection(key: _sectionKeys[4]),
                ContactSection(key: _sectionKeys[5]),
                const AppFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              onNavTap: _scrollToSection,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _BackgroundPainter(),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.accent.withValues(alpha: 0.03);

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.1),
      300,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.5),
      250,
      paint..color = AppColors.accent.withValues(alpha: 0.02),
    );

    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.8),
      200,
      paint..color = AppColors.accent.withValues(alpha: 0.02),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
