// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i12;
import 'package:furniture/domain/types/types.dart' as _i11;
import 'package:furniture/presentation/pages/brand/page_brand_list.dart' as _i1;
import 'package:furniture/presentation/pages/designer/page_designer_list.dart'
    as _i2;
import 'package:furniture/presentation/pages/furniture/page_furniture_details.dart'
    as _i3;
import 'package:furniture/presentation/pages/furniture/page_furniture_list.dart'
    as _i4;
import 'package:furniture/presentation/pages/furniture/page_furniture_router.dart'
    as _i5;
import 'package:furniture/presentation/pages/page_root.dart' as _i9;
import 'package:furniture/presentation/pages/quiz/page_quiz.dart' as _i6;
import 'package:furniture/presentation/pages/quiz/page_quiz_router.dart' as _i7;
import 'package:furniture/presentation/pages/quiz/page_quiz_setting.dart'
    as _i8;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    RouteBrandList.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PageBrandList(),
      );
    },
    RouteDesignerList.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PageDesignerList(),
      );
    },
    RouteFurnitureDetails.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child:  _i3.PageFurnitureDetails(),
      );
    },
    RouteFurnitureList.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PageFurnitureList(),
      );
    },
    RouteFurnitureRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PageFurnitureRouter(),
      );
    },
    RouteQuiz.name: (routeData) {
      final args = routeData.argsAs<RouteQuizArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PageQuiz(
          list: args.list,
          key: args.key,
        ),
      );
    },
    RouteQuizRouter.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PageQuizRouter(),
      );
    },
    RouteQuizSetting.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PageQuizSetting(),
      );
    },
    RouteRoot.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PageRoot(),
      );
    },
  };
}

/// generated route for
/// [_i1.PageBrandList]
class RouteBrandList extends _i10.PageRouteInfo<void> {
  const RouteBrandList({List<_i10.PageRouteInfo>? children})
      : super(
          RouteBrandList.name,
          initialChildren: children,
        );

  static const String name = 'RouteBrandList';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PageDesignerList]
class RouteDesignerList extends _i10.PageRouteInfo<void> {
  const RouteDesignerList({List<_i10.PageRouteInfo>? children})
      : super(
          RouteDesignerList.name,
          initialChildren: children,
        );

  static const String name = 'RouteDesignerList';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PageFurnitureDetails]
class RouteFurnitureDetails extends _i10.PageRouteInfo<void> {
  const RouteFurnitureDetails({List<_i10.PageRouteInfo>? children})
      : super(
          RouteFurnitureDetails.name,
          initialChildren: children,
        );

  static const String name = 'RouteFurnitureDetails';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PageFurnitureList]
class RouteFurnitureList extends _i10.PageRouteInfo<void> {
  const RouteFurnitureList({List<_i10.PageRouteInfo>? children})
      : super(
          RouteFurnitureList.name,
          initialChildren: children,
        );

  static const String name = 'RouteFurnitureList';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.PageFurnitureRouter]
class RouteFurnitureRouter extends _i10.PageRouteInfo<void> {
  const RouteFurnitureRouter({List<_i10.PageRouteInfo>? children})
      : super(
          RouteFurnitureRouter.name,
          initialChildren: children,
        );

  static const String name = 'RouteFurnitureRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PageQuiz]
class RouteQuiz extends _i10.PageRouteInfo<RouteQuizArgs> {
  RouteQuiz({
    required List<_i11.Furniture> list,
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          RouteQuiz.name,
          args: RouteQuizArgs(
            list: list,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'RouteQuiz';

  static const _i10.PageInfo<RouteQuizArgs> page =
      _i10.PageInfo<RouteQuizArgs>(name);
}

class RouteQuizArgs {
  const RouteQuizArgs({
    required this.list,
    this.key,
  });

  final List<_i11.Furniture> list;

  final _i12.Key? key;

  @override
  String toString() {
    return 'RouteQuizArgs{list: $list, key: $key}';
  }
}

/// generated route for
/// [_i7.PageQuizRouter]
class RouteQuizRouter extends _i10.PageRouteInfo<void> {
  const RouteQuizRouter({List<_i10.PageRouteInfo>? children})
      : super(
          RouteQuizRouter.name,
          initialChildren: children,
        );

  static const String name = 'RouteQuizRouter';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PageQuizSetting]
class RouteQuizSetting extends _i10.PageRouteInfo<void> {
  const RouteQuizSetting({List<_i10.PageRouteInfo>? children})
      : super(
          RouteQuizSetting.name,
          initialChildren: children,
        );

  static const String name = 'RouteQuizSetting';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PageRoot]
class RouteRoot extends _i10.PageRouteInfo<void> {
  const RouteRoot({List<_i10.PageRouteInfo>? children})
      : super(
          RouteRoot.name,
          initialChildren: children,
        );

  static const String name = 'RouteRoot';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
