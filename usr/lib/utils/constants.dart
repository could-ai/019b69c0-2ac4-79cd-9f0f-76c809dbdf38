import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0A58CA);
  static const Color background = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFE7F1FF);
  static const Color text = Color(0xFF0B1F44);
  static const Color icon = Color(0xFF0A58CA);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
}

class AppConstants {
  static const String appName = "H.L.-Eduroom";
  static const String homeUrl = "https://hleduroom.com/a";
  static const String blogExceptionUrl = "https://blogs.thehiteshsir.com";
  
  // JS to hide header/footer on specific domains
  static const String jsHideHeaderFooter = """
    try {
      var header = document.querySelector('header');
      var footer = document.querySelector('footer');
      if (header) header.style.display = 'none';
      if (footer) footer.style.display = 'none';
    } catch(e) {}
  """;
}
