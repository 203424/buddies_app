import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Paleta de colores
const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF0C0E13);
const Color inputGrey = Color(0xFFE8E7E7);
const Color primaryColor = Color(0xFFF3BCC8);
const Color secondaryColor = Color(0xFFDFC7D3);
const Color redColor = Color(0xFFFF4D4D);
const Color greenColor = Color(0xFF4DFF62);
const Color yellowColor = Color(0xFFFBFF4D);
const Color greyColor = Color(0xFFA3A3A3);

const MaterialColor redColorSwatch= MaterialColor(0xFFFF4D4D, {
    50: Color(0xFFFFE0E0),
    100: Color(0xFFFFB3B3),
    200: Color(0xFFFF8080),
    300: Color(0xFFFF4D4D),
    400: Color(0xFFFF2626),
    500: Color(0xFFFF0000),
    600: Color(0xFFE60000),
    700: Color(0xFFCC0000),
    800: Color(0xFFB30000),
    900: Color(0xFF990000),
  });

//Estilos (fuentes)
class Font {
  static const TextStyle textStyle =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: black);
  static const TextStyle titleBoldStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: black);
  static const TextStyle titleStyle =
      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900, color: black);
  static const TextStyle pageTitleStyle =
      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, color: black);
  static const buddiesStyle = TextStyle(fontFamily: 'Solitreo', fontSize: 30.0);

  static TextStyle numberStyle({double? fontSize, FontWeight? fontWeight}) {
    return TextStyle(
      fontFamily: 'Nunito Sans',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: black,
    );
  }
}

//Icons
class BuddiesIcons {
  static SvgPicture mascotasIcon({double? sizeIcon, Color? color}) {
    color ??= black;
    return SvgPicture.asset(
      'assets/svg/mascotas_icon.svg',
      height: sizeIcon,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static SvgPicture serviciosIcon({double? sizeIcon, Color? color}) {
    color ??= black;
    return SvgPicture.asset(
      'assets/svg/servicios_icon.svg',
      height: sizeIcon,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  static SvgPicture paseoIcon({double? sizeIcon, Color? color}) {
    color ??= black;
    return SvgPicture.asset(
      'assets/svg/paseo_icon.svg',
      height: sizeIcon,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
