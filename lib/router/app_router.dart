import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upsc_timer/main.dart';
import 'package:upsc_timer/ui/timer.dart';
import 'package:upsc_timer/widgets/splash_screen.dart';

final routes = [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return SplashScreen();
    },
    routes: <RouteBase>[
      GoRoute(
        path: 'timer',
        builder: (BuildContext context, GoRouterState state) {
          if (state.extra == 1) {
            return const TimerScreen(
              mode: 1,
            );
          } else if (state.extra == 2) {
            return const TimerScreen(
              mode: 2,
            );
          } else if (state.extra == 3) {
            return const TimerScreen(
              mode: 3,
            );
          } else if (state.extra == 4) {
            return const TimerScreen(
              mode: 4,
            );
          } else if (state.extra == 5) {
            return const TimerScreen(
              mode: 5,
            );
          } else {
            return const TimerScreen(
              mode: 1,
            );
          }
        },
      ),
      GoRoute(
        path: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const MyHomePage();
        },
      ),
    ],
  ),
];
final appRouter = GoRouter(
  initialLocation: "/",
  routes: routes,
);
