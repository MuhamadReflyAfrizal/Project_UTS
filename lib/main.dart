import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';
import 'views/activity_form_view.dart';

void main() {
  runApp(const ActivityCounterApp());
}

class ActivityCounterApp extends StatelessWidget {
  const ActivityCounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityViewModel(),
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF2563EB),
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          cardTheme: const CardThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            elevation: 2,
          ),
        ),
        routes: {
          '/': (_) => const HomeView(),
          '/form': (_) => const ActivityFormView(),
          // '/detail': (_) => const ActivityDetailView(), // Removed route requiring activityId
        },
      ),
    );
  }
}
