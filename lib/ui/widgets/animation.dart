import 'package:flutter/material.dart';

class AnimatedFlyToCart extends StatefulWidget {
  final Offset start;
  final Offset end;

  const AnimatedFlyToCart({
    super.key,
    required this.start,
    required this.end,
  });

  @override
  State<AnimatedFlyToCart> createState() => _AnimatedFlyToCartState();
}

class _AnimatedFlyToCartState extends State<AnimatedFlyToCart>
    with SingleTickerProviderStateMixin {
  late AnimationController c;
  late Animation<Offset> anim;

  @override
  void initState() {
    super.initState();

    c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    anim = Tween(
      begin: widget.start,
      end: widget.end,
    ).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));

    c.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        return Positioned(
          left: anim.value.dx,
          top: anim.value.dy,
          child: Icon(Icons.circle, size: 20, color: Colors.green),
        );
      },
    );
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }
}