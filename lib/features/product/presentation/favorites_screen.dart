import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/product.dart';
import 'product_screen.dart';
import 'provider/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    // MediaQuery values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.textScalerOf(context).scale(1.0);

    return Scaffold(
      appBar: const CommonAppBar(
        title: "My Favorites",
        showFavorites: false, // hide heart button
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                "No favorite products yet.",
                style: TextStyle(
                  fontSize: 16 * textScale,
                  color: AppColors.textMuted,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.03),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final Product product = favorites[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(screenWidth * 0.03),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.thumbnail,
                        width: screenWidth * 0.18,
                        height: screenWidth * 0.18,
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
                            const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * textScale,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: 12 * textScale,
                        color: AppColors.priceGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.iconGrey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
