import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String hint;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool readOnly;
  final bool isMandatory;
  final bool autoFocus;
  final bool isObscure;
  final String errorMassage;
  final FocusNode? focusNode;
  final double? fontSize;
  final double? textFieldHeight;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? textColor;
  final int maxLines;
  final double? horizontalPadding;
  final bool isShowCapitalLetter;
  final double? prefixIconSize;
  final double? borderRadius;
  final double? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final bool isShowDateFormat;
  final TextStyle? hintStyle;

  const AppTextFormField(
      {super.key,
      this.title = "",
      this.controller,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.name,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.onSubmitted,
      this.readOnly = false,
      this.isMandatory = false,
      this.contentPadding,
      this.textFieldHeight,
      this.hint = "",
      this.label = "",
      this.inputFormatters,
      this.fontSize,
      this.autoFocus = false,
      this.focusNode,
      this.borderColor,
      this.errorMassage = "",
      this.isObscure = false,
      this.textAlign = TextAlign.start,
      this.fontWeight = FontWeight.w400,
      this.color,
      this.textColor,
      this.suffixIcon,
      this.maxLines = 1,
      this.horizontalPadding,
      this.isShowCapitalLetter = false,
      this.prefixIconSize,
      this.borderRadius,
      this.isShowDateFormat = false,
      this.hintStyle,
      this.titlePadding,
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Row(
              children: [
                AppText(
                  text: title,
                  fontSize: 12.5,
                  fontColor: textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppAssetsConstants.nunito,
                ),
                if (isMandatory)
                  const AppText(
                    text: "*",
                    fontSize: 12.5,
                    fontColor: AppColorConstants.appRed,
                  ),
              ],
            ),
            SizedBox(
              height: titlePadding ?? 5,
            ),
          ],
          SizedBox(
            height: textFieldHeight ?? 46,
            child: TextFormField(
              onFieldSubmitted: onSubmitted,
              onTap: onTap,
              focusNode: focusNode,
              onChanged: onChanged,
              readOnly: readOnly,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              cursorWidth: 1,
              cursorColor: AppColorConstants.appPrimary,
              inputFormatters: inputFormatters,
              autofocus: autoFocus,
              obscureText: isObscure,
              textAlign: textAlign,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.5, color: AppColorConstants.appBlack),
              maxLines: maxLines,
              textCapitalization: isShowCapitalLetter ? TextCapitalization.characters : TextCapitalization.none,
              decoration: InputDecoration(
                fillColor: fillColor ?? Colors.transparent,
                filled: true,
                hintText: hint,
                hintStyle: hintStyle ?? const TextStyle(color: AppColorConstants.buttonDisableColor, fontSize: 12.5),
                label: label.isNotEmpty
                    ? AppText(
                        text: label,
                        fontSize: 12.5,
                        fontColor: AppColorConstants.buttonDisableColor,
                      )
                    : null,
                prefixIcon: prefixIcon != null
                    ? AppImageAsset(
                        image: prefixIcon,
                        height: prefixIconSize ?? 26,
                        width: prefixIconSize ?? 26,
                        color: AppColorConstants.appContinueButtonTextColor,
                      )
                    : const SizedBox(),
                prefixIconConstraints: BoxConstraints(minWidth: prefixIcon != null ? 50 : 13, maxHeight: 30),
                suffixIcon: suffixIcon,
                isDense: true,
                contentPadding:
                    contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 14).copyWith(right: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 7),
                  borderSide: BorderSide(color: borderColor ?? AppColorConstants.appTextFieldBorderColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 7),
                  borderSide: BorderSide(color: borderColor ?? AppColorConstants.appTextFieldBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 7),
                  borderSide: BorderSide(color: borderColor ?? AppColorConstants.appTextFieldBorderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 7),
                  borderSide: const BorderSide(color: AppColorConstants.appRed),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 7),
                  borderSide: BorderSide(color: readOnly ? fillColor! : AppColorConstants.appPrimary),
                ),
              ),
            ),
          ),
          if (isShowDateFormat && errorMassage.isEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 3),
              child: AppText(
                text: AppStringConstants.dateFormat.tr,
                fontSize: 9.5,
              ),
            ),
          const SizedBox(
            height: 2,
          ),
          errorMassage.isNotEmpty
              ? Container(
                  height: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: errorMassage,
                    fontSize: 10,
                    fontColor: AppColorConstants.appRed,
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
