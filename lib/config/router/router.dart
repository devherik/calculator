import 'package:calculator/view/features/history.dart';
import 'package:calculator/view/features/product_price.dart';
import 'package:calculator/view/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(routes: <RouteBase>[
    GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: 'history',
            name: 'history',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              child: const HistoryPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            path: 'product',
            name: 'product price',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              child: const ProductPricePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          )
        ])
  ], initialLocation: '/home');
}
