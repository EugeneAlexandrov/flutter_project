import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/screens.dart';

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
  final GlobalKey<NavigatorState>? navigatorKey;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
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
        if (!appStateManager.isInitialized) SplashScreen.page(),
        // TODO: Add LoginScreen
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        // TODO: Add OnboardingScreen
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        // TODO: Add Home
        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),
        // TODO: Create new item
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(onCreate: (item) {
            groceryManager.addItem(item);
          }),
        // TODO: Select GroceryItemScreen
        if (groceryManager.selectedIndex != null)
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                groceryManager.updateItem(item, index);
              }),
        // TODO: Add Profile Screen
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
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
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }
    // TODO: Handle state when user closes grocery item screen
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(null);
    }
    // TODO: Handle state when user closes profile screen
    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    // TODO: Handle state when user closes WebView screen
    return true;
  }

  //this is for parser
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
