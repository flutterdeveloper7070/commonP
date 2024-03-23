import 'package:predator_pest/app/common_imports/common_imports.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile(
      {super.key,
      this.leading,
      @required this.title,
      this.backgroundColor,
      this.fontColor,
      this.fontWeight,
      this.onExpansionChanged,
      this.children = const <ExpansionTileChildDetail>[],
      this.trailing,
      this.initiallyExpanded = false,
      this.onTap,
      this.customChildren,
      this.leadingOnTap});

  final String? leading;
  final String? title;
  final ValueChanged<bool>? onExpansionChanged;
  final List<ExpansionTileChildDetail> children;
  final Color? backgroundColor;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final Widget? trailing;
  final bool initiallyExpanded;
  final GestureTapCallback? onTap;
  final GestureTapCallback? leadingOnTap;
  final List<Widget>? customChildren;

  @override
  AppExpansionTileState createState() => AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _arrowController;
  late CurvedAnimation _easeOutAnimation;
  late CurvedAnimation _easeInAnimation;
  late ColorTween _borderColor;
  late ColorTween _headerColor;
  late ColorTween _iconColor;
  late ColorTween _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _arrowController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _easeOutAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = ColorTween();
    _headerColor = ColorTween();
    _iconColor = ColorTween();
    _backgroundColor = ColorTween();

    _isExpanded = PageStorage.of(context).readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded) {
          _arrowController.reverse(from: 0.5);
          _controller.forward();
        } else {
          _arrowController.forward(from: 0.5);
          _controller.reverse().then<void>((void value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        }
        PageStorage.of(context).writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColorConstants.appWhite,
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.1), width: 1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
            child: InkWell(
              overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
              onTap: widget.onTap ?? toggle,
              child: Container(
                height: widget.customChildren != null ? null : 47,
                // margin: const EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6).copyWith(right: 5),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(color: AppColorConstants.appWhite),
                child: Row(
                  children: [
                    widget.leading != null && widget.leading!.isNotEmpty
                        ? InkWell(
                            onTap: widget.leadingOnTap,
                            child: SizedBox(
                              height: 20,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 3, right: 12),
                                  child: AppImageAsset(
                                    image: widget.leading,
                                    height: 20,
                                  )),
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                        child: AppText(
                      text: widget.title!,
                      fontColor: widget.fontColor ?? AppColorConstants.appPrimary,
                      maxLines: 2,
                      fontFamily: AppAssetsConstants.nunito,
                      fontWeight: widget.fontWeight ?? FontWeight.w700,
                      fontSize: 13.4,
                    )),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_arrowController),
                      child: SizedBox(
                        width: widget.customChildren != null ? null : 35,
                        child: Icon(
                          _isExpanded ? Icons.expand_less_rounded : Icons.arrow_forward_ios_rounded,
                          color: AppColorConstants.appBlack,
                          size: _isExpanded ? 26 : 17,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // child: ListTile(
            //   onTap: toggle,
            //   leading: widget.leading,
            //   title: DefaultTextStyle(
            //     style: Theme
            //         .of(context)
            //         .textTheme
            //         .titleMedium!
            //         .copyWith(color: titleColor),
            //     child: ,
            //   ),
            //   trailing: widget.trailing ?? RotationTransition(
            //     turns: _iconTurns,
            //     child: const Icon(Icons.expand_more),
            //   ),
            // ),
          ),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.titleMedium!.color
      ..end = theme.colorScheme.secondary;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.colorScheme.secondary;
    _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Padding(
              padding: EdgeInsets.only(left: widget.customChildren != null ? 0 : 15),
              child: Column(
                  children: widget.customChildren ??
                      widget.children.map((e) {
                        return InkWell(
                          onTap: e.onTap,
                          child: Container(
                              height: 45,
                              margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(right: 5),
                              alignment: Alignment.centerLeft,
                              // color: AppColorConstant.appWhite.withOpacity(0.5),
                              decoration: BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(color: AppColorConstants.appWhite.withOpacity(0.3)))),
                              child: AppText(text: e.title!, fontColor: AppColorConstants.appWhite.withOpacity(0.7))),
                        );
                      }).toList()),
            ),
    );
  }
}

class ExpansionTileChildDetail {
  final String? title;
  final GestureTapCallback? onTap;

  ExpansionTileChildDetail({this.title, this.onTap});
}
