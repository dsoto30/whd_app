import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/core/app_routes.dart';
import 'package:whd_app/viewmodels/auth_controller.dart';
import 'package:whd_app/views/profile_view.dart';
import 'package:whd_app/views/tickets_view.dart';

/// Signed-in shell: hosts the Profile and Tickets tabs behind a bottom
/// navigation bar, plus the logout action in the app bar.
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  static const _titles = ['Profile', 'Tickets'];
  static const _tabs = [ProfileView(), TicketsView()];

  int _tabIndex = 0;
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    final navigator = Navigator.of(context);
    setState(() => _isLoggingOut = true);
    await ref.read(authControllerProvider.notifier).logout();
    if (!mounted) return;
    navigator.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabIndex]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: _isLoggingOut ? null : _logout,
            icon: _isLoggingOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) => setState(() => _tabIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
        ],
      ),
    );
  }
}
