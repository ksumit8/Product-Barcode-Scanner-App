import 'package:flutter/material.dart';

import '../../features/product/presentation/favorites_screen.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({super.key, required String title})
      : super(
    title: Center(child: Text(title)),
    actions: [
      IconButton(
        icon: const Icon(Icons.favorite, color: Colors.red),
        onPressed: (context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FavoritesScreen(),
            ),
          );
        }.bindContext,
      ),
    ],
  );
}

// 🔥 Helper extension to allow using BuildContext in AppBar actions
extension _CallbackWithContext on void Function(BuildContext) {
  void Function() get bindContext {
    return () {
      final ctx = WidgetsBinding.instance.focusManager.primaryFocus?.context;
      if (ctx != null) this(ctx);
    };
  }
}
