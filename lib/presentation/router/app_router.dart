import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: RouteRoot.page,
      children: [
        AutoRoute(
          initial: true,
          path: 'furniture',
          page: RouteFurnitureRouter.page,
          children: [
            AutoRoute(
              initial: true,
              path: 'list',
              page: RouteFurnitureList.page,
            ),
            AutoRoute(
              // initial: true,// TODO: 完成したら消す
              path: 'details',
              page: RouteFurnitureDetails.page,
            ),
          ]
        ),
        AutoRoute(
          path: 'designer',
          page: RouteDesignerList.page,
        ),
        AutoRoute(
          path: 'brand',
          page: RouteBrandList.page,
        ),
        AutoRoute(
          // initial: true,
          path: 'quiz',
          page: RouteQuizRouter.page,
          children: [
            AutoRoute(
              // initial: true,
              path: 'setting',
              page: RouteQuizSetting.page,
            ),
            AutoRoute(
              page: RouteQuiz.page,
            ),
          ]
        ),
      ],
    ),
  ];
}

