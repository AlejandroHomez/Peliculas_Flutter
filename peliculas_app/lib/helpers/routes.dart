import 'package:flutter/material.dart';

VoidCallback pushNamedAndRemoveUntil(
  String routeName,
  BuildContext context,
  Object? arguments,
) {
  return () {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments != null ? arguments : null,
    );
  };
}

VoidCallback pushNamed(
  String routeName,
  BuildContext context,
  Object? arguments,
) {
  return () {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments != null ? arguments : null,
    );
  };
}

VoidCallback push(
  BuildContext context,
  Widget route,
  Object? arguments,
) {
  return () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  };
}

VoidCallback pop(
  BuildContext context,
) {
  return () {
    Navigator.pop(context);
  };
}
