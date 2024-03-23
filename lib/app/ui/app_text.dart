import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? wordSpacing;
  final double? letterSpacing;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final double? height;
  final TextStyle? textStyle;
  final double? textScaleFactor;

  const AppText(
      {super.key,
        @required this.text,
        this.fontSize,
        this.fontWeight,
        this.fontColor,
        this.textAlign,
        this.overflow,
        this.maxLines,
        this.wordSpacing,
        this.letterSpacing,
        this.fontFamily,
        this.fontStyle,
        this.decoration,
        this.height,
        this.textStyle,
        this.textScaleFactor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontFamily: fontFamily,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight,
        color: fontColor,
        wordSpacing: wordSpacing,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
    );
  }
}

Widget appTextWithUnderLine({String title = '',Color fontColor = AppColorConstants.appBlack}){
  return Text(
    title,
    style: TextStyle(
        color: AppColorConstants.appTransparent,
        fontWeight: FontWeight.w500,
        fontSize: 11.5,
        height: 2.5,
        shadows: [
          Shadow(
              color: fontColor,
              offset: const Offset(0, -4))
        ],
        decoration:
        TextDecoration.underline,
        decorationColor: AppColorConstants.appBorderColor.withOpacity(0.7),
        decorationThickness: 1.8
    ),
  );
}


class AppExpandableTextWidget extends StatefulWidget {
  const AppExpandableTextWidget(
      this.text, {
        super.key,
        this.trimLines = 2,
      });

  final String text;
  final int trimLines;

  @override
  AppExpandableTextWidgetState createState() => AppExpandableTextWidgetState();
}

class AppExpandableTextWidgetState extends State<AppExpandableTextWidget> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    const colorClickableText = AppColorConstants.mediumGray;
    const widgetColor = AppColorConstants.appBlack;
    TextSpan link = TextSpan(
        text: _readMore ? " ${AppStringConstants.readMore.tr}." : " ${AppStringConstants.readLess.tr}.",
        style: const TextStyle(
            color: colorClickableText,
            fontWeight: FontWeight.w600,
            fontSize: 10,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink
    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
          style:
            const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis,
            ),
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,//better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore
                ? "${widget.text.substring(0, endIndex)}...."
                : widget.text,
            style: const TextStyle(
                color: widgetColor,
                fontSize: 11.5,
                height: 1.31,
                fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: const  TextStyle(
              color: widgetColor,
              fontSize: 11.5,
              height: 1.31,
              fontWeight: FontWeight.w400,
            ),
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}