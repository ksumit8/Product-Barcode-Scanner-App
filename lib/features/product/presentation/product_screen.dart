import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/product.dart';
import 'provider/favorites_provider.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(product);

    // MediaQuery values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);

    return Scaffold(
      appBar: const CommonAppBar(title: "Product"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image with Gradient Background
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.cardGradientStart,
                    AppColors.cardGradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: screenWidth < 400 ? 1 : 1.2,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.loader,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Product Name
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20 * textScale,
                    color: AppColors.textPrimary,
                  ),
            ),
            SizedBox(height: screenHeight * 0.01),

            // Product Price
            Text(
              "\$${product.price}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18 * textScale,
                fontWeight: FontWeight.w600,
                color: AppColors.priceGreen,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Favorite Button with Animation
            ElevatedButton.icon(
              onPressed: () {
                favoritesProvider.toggleFavorite(product);
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, anim) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: anim,
                      curve: Curves.elasticOut,
                    ),
                    child: FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFavorite),
                  color: isFavorite
                      ? AppColors.heartGradientEnd
                      : AppColors.iconGrey,
                  size: screenWidth * 0.07,
                ),
              ),
              label: Text(
                isFavorite ? "Remove Favorite" : "Add to Favorite",
                style: TextStyle(
                  fontSize: 14 * textScale,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBackground,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
