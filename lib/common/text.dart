import 'package:flutter/material.dart';

class TextStyleSet {
  const TextStyleSet({
    required this.baseTextStyle,
    required this.sizes,
  });

  final TextStyle baseTextStyle;
  final List<double> sizes;

  TextStyle getStyleFor(int size) {
    assert(size >= 0);
    assert(size < sizes.length);

    return baseTextStyle.copyWith(
      fontSize: sizes[size].toDouble(),
    );
  }
}

class AppTextStyles {
  const AppTextStyles(_);

  static TextStyle _baseDisplayStyle = TextStyle(
    fontFamily: 'Manrope',
    letterSpacing: -0.5,
  );
  static TextStyle _baseBodyStyle = TextStyle(
    fontFamily: 'Open Sans',
  );

  static TextStyleSet display = TextStyleSet(
      baseTextStyle: _baseDisplayStyle, sizes: [64, 48, 32, 24, 20, 16, 12]);
  static TextStyleSet body = TextStyleSet(
      baseTextStyle: _baseBodyStyle, sizes: [64, 48, 32, 24, 20, 16, 12]);
}
