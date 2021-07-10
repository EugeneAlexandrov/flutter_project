import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:provider/provider.dart';
import 'fooderlich_theme.dart';
import 'navigation/app_router.dart';
import 'models/models.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  final AppStateManager _appStateManager = AppStateManager();
  final GroceryManager _groceryManager = GroceryManager();
  final ProfileManager _profileManager = ProfileManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager),
        ChangeNotifierProvider(create: (context) => _groceryManager),
        ChangeNotifierProvider(create: (context) => _profileManager),
      ],
      child: MaterialApp(
        theme: FooderlichTheme.dark(),
        title: 'Fooderlich',
        // TODO: Replace with Router widget
        home: Router(
          routerDelegate: _appRouter,
        ),
      ),
    );
  }
}
