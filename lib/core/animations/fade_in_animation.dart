import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants/app_durations.dart';

enum SlideDirection { fromBottom, fromLeft, fromRight, fromTop, none }

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final SlideDirection direction;
  final double slideOffset;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppDurations.entrance,
    this.direction = SlideDirection.fromBottom,
    this.slideOffset = 30,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    final begin = _getBeginOffset();
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  Offset _getBeginOffset() {
    final offset = widget.slideOffset;
    switch (widget.direction) {
      case SlideDirection.fromBottom:
        return Offset(0, offset);
      case SlideDirection.fromTop:
        return Offset(0, -offset);
      case SlideDirection.fromLeft:
        return Offset(-offset, 0);
      case SlideDirection.fromRight:
        return Offset(offset, 0);
      case SlideDirection.none:
        return Offset.zero;
    }
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
        return Transform.translate(
          offset: _slide.value,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class ScrollFadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final SlideDirection direction;
  final double slideOffset;

  const ScrollFadeIn({
    super.key,
    required this.child,
    this.duration = AppDurations.entrance,
    this.direction = SlideDirection.fromBottom,
    this.slideOffset = 30,
  });

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hasAnimated = false;
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    final begin = _getBeginOffset();
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  Offset _getBeginOffset() {
    final offset = widget.slideOffset;
    switch (widget.direction) {
      case SlideDirection.fromBottom:
        return Offset(0, offset);
      case SlideDirection.fromTop:
        return Offset(0, -offset);
      case SlideDirection.fromLeft:
        return Offset(-offset, 0);
      case SlideDirection.fromRight:
        return Offset(offset, 0);
      case SlideDirection.none:
        return Offset.zero;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scrollable = Scrollable.maybeOf(context);
    scrollable?.position.addListener(_checkVisibility);
  }

  void _checkVisibility() {
    if (!mounted || _hasAnimated) return;

    final renderObject =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderObject == null || !renderObject.hasSize) {
      _scheduleCheck();
      return;
    }

    try {
      final viewport = RenderAbstractViewport.maybeOf(renderObject);
      if (viewport == null) {
        _scheduleCheck();
        return;
      }
      final revealOffset = viewport.getOffsetToReveal(renderObject, 0.0);
      final scrollableState = Scrollable.maybeOf(context);
      if (scrollableState == null) {
        _scheduleCheck();
        return;
      }

      final scrollPosition = scrollableState.position;
      final viewportHeight = scrollPosition.viewportDimension;
      final scrollOffset = scrollPosition.pixels;
      final widgetTop = revealOffset.offset;

      if (widgetTop < scrollOffset + viewportHeight * 0.85 &&
          widgetTop + renderObject.size.height > scrollOffset) {
        _hasAnimated = true;
        _controller.forward();
        return;
      }
    } catch (_) {
      // Viewport calculation failed, schedule retry
    }

    _scheduleCheck();
  }

  void _scheduleCheck() {
    if (mounted && !_hasAnimated) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _slide.value,
            child: Opacity(
              opacity: _opacity.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
