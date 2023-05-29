part of styles;

class AppFonts {
  static TextStyle getAppFont({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color,
  }) {
    return GoogleFonts.inter(
        textStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ));
  }
}

class HeaderFonts {
 static final primaryText = AppFonts.getAppFont(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white);
       static final secondaryText = AppFonts.getAppFont(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white);
}

class TextFonts {
   static final primaryText = AppFonts.getAppFont(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color.fromARGB(255,39, 39, 74,));
 static final secondaryText = AppFonts.getAppFont(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color.fromARGB(255,95, 96, 126,));
 
  static final ternaryText = AppFonts.getAppFont(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color:Colors.black);
  
}

// class ButtonText {
//   static final primaryText = AppFonts.getAppFont(
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       color: ButtonColor.primaryColor);
  
// }
