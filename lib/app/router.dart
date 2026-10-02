import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/insights/insights_screen.dart';
import '../features/log/daily_log_screen.dart';
import '../features/photos/photos_screen.dart';
import '../core/db/app_database.dart';
import '../core/utils/date_utils.dart';
import '../features/products/product_detail_screen.dart';
import '../features/products/product_form_screen.dart';
import '../features/products/products_screen.dart';
import '../features/routines/routine_editor_screen.dart';
import '../features/routines/routines_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/today/today_screen.dart';
import 'shell_scaffold.dart';

abstract final class AppRoutes {
  static const today = '/today';
  static const products = '/products';
  static const photos = '/photos';
  static const insights = '/insights';
  static const settings = '/settings';

  static const productNew = '/product/new';
  static const productNewWishlist = '/product/new?status=wishlist';
  static String productDetail(int id) => '/product/$id';
  static String productEdit(int id) => '/product/$id/edit';

  static const routines = '/routines';
  static String routine(int id) => '/routines/$id';
  static String dailyLog(DateTime day) => '/log/${toDateKey(day)}';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.today,
    routes: [
      GoRoute(
        path: AppRoutes.routines,
        builder: (context, state) => const RoutinesScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) =>
                RoutineEditorScreen(routineId: _id(state)),
          ),
        ],
      ),
      GoRoute(
        path: '/log/:date',
        builder: (context, state) =>
            DailyLogScreen(date: state.pathParameters['date']!),
      ),
      GoRoute(
        path: AppRoutes.productNew,
        builder: (context, state) => ProductFormScreen(
          initialStatus: state.uri.queryParameters['status'] == 'wishlist'
              ? ProductStatus.wishlist
              : null,
        ),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductDetailScreen(productId: _id(state)),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) =>
                ProductFormScreen(productId: _id(state)),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ShellScaffold(shell: shell),
        branches: [
          _branch(AppRoutes.today, const TodayScreen()),
          _branch(AppRoutes.products, const ProductsScreen()),
          _branch(AppRoutes.photos, const PhotosScreen()),
          _branch(AppRoutes.insights, const InsightsScreen()),
          _branch(AppRoutes.settings, const SettingsScreen()),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);

int _id(GoRouterState state) => int.parse(state.pathParameters['id']!);
