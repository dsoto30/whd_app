import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/core/app_theme.dart';
import 'package:whd_app/models/tech.dart';
import 'package:whd_app/viewmodels/tech_providers.dart';

/// Profile tab: the logged-in tech at the top, followed by a "My Team"
/// list of everyone on the team. Pull to refresh re-fetches both.
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTech = ref.watch(currentTechProvider);
    final team = ref.watch(teamTechsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(currentTechProvider);
        ref.invalidate(teamTechsProvider);
        await Future.wait([
          ref.read(currentTechProvider.future),
          ref.read(teamTechsProvider.future),
        ]);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _CurrentTechCard(tech: currentTech),
          const SizedBox(height: 24),
          Text(
            'My Team',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _TeamList(team: team),
        ],
      ),
    );
  }
}

/// Header card for the currently logged-in tech.
class _CurrentTechCard extends StatelessWidget {
  const _CurrentTechCard({required this.tech});

  final AsyncValue<Tech> tech;

  @override
  Widget build(BuildContext context) {
    return tech.when(
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Could not load your profile: $error'),
        ),
      ),
      data: (t) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _TechAvatar(name: t.displayName, radius: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.displayName,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      t.type,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The "My Team" list rendered from the team fetch.
class _TeamList extends StatelessWidget {
  const _TeamList({required this.team});

  final AsyncValue<List<Tech>> team;

  @override
  Widget build(BuildContext context) {
    return team.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Could not load the team: $error'),
      ),
      data: (techs) {
        if (techs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No team members found.'),
          );
        }
        return Column(
          children: [
            for (final t in techs)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: _TechAvatar(name: t.displayName, radius: 20),
                  title: Text(t.displayName),
                  subtitle: Text(t.type),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Circular avatar showing a tech's initials.
class _TechAvatar extends StatelessWidget {
  const _TechAvatar({required this.name, required this.radius});

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.turquoise,
      child: Text(
        _initials(name),
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontSize: radius * 0.7,
        ),
      ),
    );
  }
}

/// First letters of the first and last word of [name] (e.g. "Ada Lovelace" -> "AL").
String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}
