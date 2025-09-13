import 'package:flutter/material.dart';
import '../../features/product/presentation/favorites_screen.dart';
import '../../core/theme/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showFavorites;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showFavorites = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);
    final titleFontSize = (screenWidth * 0.055) * textScale;

    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 6,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: AppColors.appBarText,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.appBarGradientStart,
              AppColors.appBarGradientEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: showFavorites
          ? [
        Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.03),
          child: _AnimatedHeartButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
            size: screenWidth * 0.08,
          ),
        ),
      ]
          : null,
    );
  }
}

class _AnimatedHeartButton extends StatefulWidget {
  final VoidCallback onTap;
  final double size;

  const _AnimatedHeartButton({
    required this.onTap,
    required this.size,
  });

  @override
  State<_AnimatedHeartButton> createState() => _AnimatedHeartButtonState();
}

class _AnimatedHeartButtonState extends State<_AnimatedHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.8,
      upperBound: 1.2,
    );
  }

  void _animate() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: InkWell(
        onTap: _animate,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                AppColors.heartGradientStart,
                AppColors.heartGradientEnd,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.heartShadow,
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: widget.size,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
