import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/i18n/l10n_extension.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.translate('store')),
        backgroundColor: AppColors.cardBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildStoreItem(
              context,
              title: "🔥 Flame Katana Skin",
              description: "Fire particle trail on sword slashes",
              price: "\$1.99",
            ),
            _buildStoreItem(
              context,
              title: "⚡ Lightning Rapier Skin",
              description: "Electric arc effect on strike",
              price: "\$1.99",
            ),
            _buildStoreItem(
              context,
              title: "🛡️ Samurai Armor Outfit",
              description: "Golden samurai plate armor for Milo",
              price: "\$2.99",
            ),
            _buildStoreItem(
              context,
              title: "🚫 Remove Ads & Infinite Potions",
              description: "Permanent ad-free play + 2x coin multiplier",
              price: "\$3.99",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreItem(
    BuildContext context, {
    required String title,
    required String description,
    required String price,
  }) {
    return Card(
      color: AppColors.cardBackground,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentGold),
        ),
        subtitle: Text(description, style: const TextStyle(color: AppColors.textMuted)),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.shadowPurple),
          child: Text(price),
        ),
      ),
    );
  }
}
