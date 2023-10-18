import 'package:flutter/material.dart';
import 'package:task/product_detail_view.dart';
import 'package:task/products_view.dart';
import 'package:task/sign_in_view.dart';
import 'package:task/splash_view.dart';

class AppRoutes {
  static const String splashView = "/splash_view";
  static const String signInView = "/sign_in_view";
  static const String productsView = "/products_view.dart";
  static const String productDetailView = "/product_detail_view.dart";

  static Route getRoutes(RouteSettings routeSettings) {
    Object? arguments = routeSettings.arguments;

    print("Current route ${routeSettings.name}");

    switch (routeSettings.name) {
      case AppRoutes.signInView:
        {
          return setTransition(routeSettings, SignInView(map: arguments));
        }

      case AppRoutes.productsView:
        {
          return setTransition(routeSettings, ProductsView(arguments));
        }

      case AppRoutes.productDetailView:
        {
          return setTransition(routeSettings, ProductDetailView(arguments));
        }

      default:
        {
          return setTransition(routeSettings, const SplashView());
        }
    }
  }

  static Route setTransition(RouteSettings settings, Widget widget) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => widget,
    );
  }
}
