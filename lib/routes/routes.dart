import 'package:gensinicalc/features/gensini_calculator/presentation/pages/welcome_page.dart';
import 'package:go_router/go_router.dart';
import 'package:gensinicalc/features/gensini_calculator/presentation/pages/calculator_page.dart';

class AppRoutes {
  static const String calculator = '/calculator';
  static const String welcomePage = '/welcome';

  static final GoRouter router = GoRouter(
    initialLocation: welcomePage,

    routes: <RouteBase>[
      GoRoute(
        name: 'welcomePage',
        path: welcomePage,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: 'calculator',
        path: calculator,
        builder: (context, state) => const CalculatorPage(),
      ),
    ],
  );
}
