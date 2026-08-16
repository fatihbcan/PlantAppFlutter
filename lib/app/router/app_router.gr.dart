// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:hubx_flutter_case/features/home/presentation/view/home_page.dart'
    as _i1;
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/view/intro_page.dart'
    as _i2;
import 'package:hubx_flutter_case/features/onboarding/presentation/paywall/view/paywall_page.dart'
    as _i3;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.IntroPage]
class IntroRoute extends _i4.PageRouteInfo<void> {
  const IntroRoute({List<_i4.PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.IntroPage();
    },
  );
}

/// generated route for
/// [_i3.PaywallPage]
class PaywallRoute extends _i4.PageRouteInfo<PaywallRouteArgs> {
  PaywallRoute({
    bool completesOnboarding = true,
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         PaywallRoute.name,
         args: PaywallRouteArgs(
           completesOnboarding: completesOnboarding,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'PaywallRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaywallRouteArgs>(
        orElse: () => const PaywallRouteArgs(),
      );
      return _i3.PaywallPage(
        completesOnboarding: args.completesOnboarding,
        key: args.key,
      );
    },
  );
}

class PaywallRouteArgs {
  const PaywallRouteArgs({this.completesOnboarding = true, this.key});

  final bool completesOnboarding;

  final _i5.Key? key;

  @override
  String toString() {
    return 'PaywallRouteArgs{completesOnboarding: $completesOnboarding, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaywallRouteArgs) return false;
    return completesOnboarding == other.completesOnboarding && key == other.key;
  }

  @override
  int get hashCode => completesOnboarding.hashCode ^ key.hashCode;
}
