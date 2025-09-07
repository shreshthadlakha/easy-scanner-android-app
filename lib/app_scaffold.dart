import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'bottom_nav_bar.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate based on tab selection
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/docs');
        break;
      case 2:
        context.go('/new-folder');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  bool _isOnHomeScreen() {
    final String location = GoRouterState.of(context).uri.toString();
    return location == '/';
  }

  bool _canPop() {
    // Allow popping if we're not on the home screen
    return !_isOnHomeScreen();
  }

  void _handleBackButton() {
    final String location = GoRouterState.of(context).uri.toString();
    
    if (location == '/') {
      // On home screen - show exit confirmation
      _showExitDialog();
    } else if (location == '/camera') {
      // From camera screen, go back to home
      context.go('/');
    } else {
      // From any other screen, try to pop or go to home
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Update current index based on current route
    final String location = GoRouterState.of(context).uri.toString();
    
    // Don't show bottom navigation on camera screen
    final bool showBottomNav = location != '/camera';
    
    switch (location) {
      case '/':
        _currentIndex = 0;
        break;
      case '/docs':
        _currentIndex = 1;
        break;
      case '/new-folder':
        _currentIndex = 2;
        break;
      case '/settings':
        _currentIndex = 3;
        break;
      default:
        // For camera or other screens, keep current index
        break;
    }

    return PopScope(
      canPop: false, // Always handle back button manually
      onPopInvoked: (didPop) {
        if (!didPop) {
          _handleBackButton();
        }
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: showBottomNav
            ? BottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              )
            : null,
      ),
    );
  }
}