import 'package:flutter/material.dart';

enum TextWeight { Regular, Medium, Bold, ExtraBold }

class TextStyleSet {
  const TextStyleSet({
    required this.baseTextStyle,
    required this.sizes,
  });

  final TextStyle baseTextStyle;
  final List<double> sizes;

  FontWeight getWeight(TextWeight weight) {
    switch (weight) {
      case TextWeight.Regular:
        return FontWeight.normal;
      case TextWeight.Medium:
        return FontWeight.w500;
      case TextWeight.Bold:
        return FontWeight.w600;
      case TextWeight.ExtraBold:
        return FontWeight.w800;
    }
  }

  TextStyle getStyleFor(int size,
      {TextWeight weight = TextWeight.Regular, Color? color}) {
    assert(size >= 0);
    assert(size < sizes.length);

    return baseTextStyle.copyWith(
      fontSize: sizes[size].toDouble(),
      fontWeight: getWeight(weight),
      color: color,
    );
  }
}

class AppTextStyles {
  const AppTextStyles(_);

  static TextStyle _baseDisplayStyle = TextStyle(
    fontFamily: 'Rubik',
    letterSpacing: -0.5,
  );
  static TextStyle _baseBodyStyle = TextStyle(
    fontFamily: 'Open Sans',
  );

  static TextStyleSet display = TextStyleSet(
      baseTextStyle: _baseDisplayStyle,
      sizes: [64, 48, 32, 24, 20, 16, 14, 12]);
  static TextStyleSet body = TextStyleSet(
      baseTextStyle: _baseBodyStyle, sizes: [64, 48, 32, 24, 20, 16, 14, 12]);
}
