import 'package:flutter/material.dart';
import 'package:whd_app/core/app_theme.dart';

/// Tickets tab. Placeholder until ticket listing is specced.
class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.confirmation_number_outlined,
            size: 48,
            color: AppColors.muted,
          ),
          const SizedBox(height: 12),
          Text(
            'Tickets coming soon',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
