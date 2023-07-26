import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Paleta de colores
const Color white = Color(0xFFECECEC);
const Color black = Color(0xFF0C0E13);
const Color inputGrey = Color(0xffF8F8F8);
const Color primaryColor = Color(0xFFF3BCC8);
const Color secondaryColor = Color(0xFFDFC7D3);
const Color redColor = Color(0xFFFF4D4D);
const Color greenColor = Color(0xFF46E558);
const Color yellowColor = Color(0xFFFBFF4D);
const Color greyColor = Color(0xFFA3A3A3);
const Color greyColorStatusBar = Color(0xFFC4C4C4);

const MaterialColor redColorSwatch = MaterialColor(0xFFFF4D4D, {
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

class Config {
  static String apiKey = dotenv.get('API_KEY');
}

//Estilos (fuentes)
class Font {
  static const TextStyle textStyle =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: black);

  static const TextStyle textStyleGrey =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: greyColor);

  static const TextStyle textStyleRed =
      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: redColor);

  static TextStyle textStyleBold({Color? color, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? 14.0,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static const TextStyle titleBoldStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: black);

  static const TextStyle titleStyle =
      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900, color: black);
  static const TextStyle pageTitleStyle =
      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400, color: black);
  static TextStyle buddiesStyle({Color? color}) {
    return TextStyle(
      fontFamily: 'Solitreo',
      fontSize: 40.0,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

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
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/mascotas_icon.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/mascotas_icon.svg',
        height: sizeIcon,
      );
    }
  }

  static SvgPicture serviciosIcon({double? sizeIcon, Color? color}) {
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/servicios_icon.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/servicios_icon.svg',
        height: sizeIcon,
      );
    }
  }

  static SvgPicture paseoIcon({double? sizeIcon, Color? color}) {
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/paseo_icon.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/paseo_icon.svg',
        height: sizeIcon,
      );
    }
  }

  static SvgPicture logo({double? sizeIcon, Color? color}) {
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/logo.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/logo.svg',
        height: sizeIcon,
      );
    }
  }

  static SvgPicture logoRounded({double? sizeIcon, Color? color}) {
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/logo_rounded.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/logo_rounded.svg',
        height: sizeIcon,
      );
    }
  }

  static SvgPicture pinMascota({double? sizeIcon, Color? color}) {
    if (color != null) {
      return SvgPicture.asset(
        'assets/svg/pin_mascota_icon.svg',
        height: sizeIcon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset(
        'assets/svg/pin_mascota_icon.svg',
        height: sizeIcon,
      );
    }
  }
}

//pages
class Pages {
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String addPetPage = "addPetPage";
  static const String requestFormPage = "requestFormPage";
  static const String selectServicePage = "selectServicePage";
  static const String historyListPage = "historyListPage";
  static const String servicesListPage = "servicesListPage";
  static const String serviceInProgressPage = "serviceInProgressPage";
  static const String addPetToServicesPage = "addPetToServicesPage";
  static const String selectLocationPage = "selectLocationPage";
  static const String updatePetPage = "updatePetPage";
  static const String accountFormPage = "accountFormPage";
}
