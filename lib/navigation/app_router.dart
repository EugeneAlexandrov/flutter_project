import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

//It extends RouterDelegate.
//The system will tell the router to build and configure a navigator widget.
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  // Declares GlobalKey, a unique key across the entire app.
  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? navigatorKey;

  AppRouter(this.appStateManager, this.groceryManager, this.profileManager)
      : navigatorKey = GlobalKey<NavigatorState>() {
    // TODO: Add listeners
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  // TODO: Dispose listeners
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  //RouterDelegate requires you to add a build().
  // This configures your navigator and pages.
  @override
  Widget build(BuildContext context) {
    //Configures a Navigator
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      //Declares pages, the stack of pages that describes your navigation stack.
      pages: [
        // TODO: Add SplashScreen
        // TODO: Add LoginScreen
        // TODO: Add OnboardingScreen
        // TODO: Add Home
        // TODO: Create new item
        // TODO: Select GroceryItemScreen
        // TODO: Add Profile Screen
        // TODO: Add WebView Screen
      ],
    );
  }

  // TODO: Add _handlePopPage
  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    // TODO: Handle Onboarding and splash
    // TODO: Handle state when user closes grocery item screen
    // TODO: Handle state when user closes profile screen
    // TODO: Handle state when user closes WebView screen
    return true;
  }

  //this is for parser
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
