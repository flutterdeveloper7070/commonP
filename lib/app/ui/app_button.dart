import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final Function()? onTap;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final String? fontFamily;
  final BoxBorder? border;

  const AppButton(
      {super.key,
      @required this.onTap,
      @required this.text,
      this.color,
      this.textColor,
      this.height,
      this.width,
      this.textStyle,
      this.alignment,
      this.padding,
      this.textAlign,
      this.fontWeight,
      this.fontSize,
      this.border,
      this.borderRadius,this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height ?? 44,
        width: width,
        alignment: alignment ?? Alignment.center,
        decoration: BoxDecoration(
            border: border,
            color: color ?? AppColorConstants.appPrimary,
            borderRadius: borderRadius ?? BorderRadius.circular(8)),
        child: Text(
          text!,
          style: textStyle ??
              TextStyle(
                  fontSize: fontSize ?? 14,
                  color: textColor ?? Colors.white,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontFamily: fontFamily),
        ),
      ),
    );
  }
}
