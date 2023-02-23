import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final _ButtonType _buttonType;
  final bool busy;
  final bool iconIsImage;
  final bool disable;
  final double width;
  final IconData? leadingIcon;
  final Color? color;
  const MyButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.busy = false,
      this.iconIsImage = false,
      this.disable = false,
      this.width = double.maxFinite,
      this.leadingIcon,
      this.color})
      : _buttonType = _ButtonType.filled,
        super(key: key);
  const MyButton.outlined(
      {Key? key,
      required this.text,
      this.onTap,
      this.busy = false,
      this.disable = false,
      this.width = double.maxFinite,
      this.leadingIcon,
      this.color})
      : _buttonType = _ButtonType.outlined,
        this.iconIsImage = false,
        super(key: key);
  const MyButton.text(
      {Key? key,
      required this.text,
      this.onTap,
      this.busy = false,
      this.disable = false,
      this.width = double.maxFinite,
      this.leadingIcon,
      this.color})
      : _buttonType = _ButtonType.text,
        this.iconIsImage = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getButtonColor(context),
      animationDuration: const Duration(milliseconds: 500),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: _buttonType == _ButtonType.outlined
              ? BorderSide(color: color ?? kcPrimary, width: 1.0)
              : BorderSide.none),
      child: SizedBox(
        width: width,
        height: 48.0,
        child: InkWell(
          splashColor: _buttonType == _ButtonType.filled
              ? color?.withOpacity(0.5)
              : null,

          // highlightColor: kcPrimarySwatch[],
          splashFactory: InkRipple.splashFactory,
          onTap: disable || busy ? null : onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (leadingIcon != null && !busy)
                Icon(
                  leadingIcon,
                  color: getTextColor(context),
                ),
              if (leadingIcon != null && !busy) horizontalSpaceTiny,
              if (!busy) Text(text, 
              style: TextStyle(color: Colors.white),
              // color: getTextColor(context)
              ),
              if (busy)
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColorDark),
                    strokeWidth: 3.0,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Color getButtonColor(BuildContext context) => disable
      ? kcGreyLight
      : busy
          ? kcGreyLight
          : _buttonType == _ButtonType.filled
              ? color ?? kcPrimary
              : Colors.transparent;
  Color getTextColor(BuildContext context) => disable
      ? kcGreyDark
      : _buttonType == _ButtonType.filled
          ? Colors.white
          : color ?? kcPrimary;
}

enum _ButtonType { filled, outlined, text }


const Color kcPrimary = Color(0xff253D79);
//253D79
const Color kcGreyDark = Color(0xff868686);


const Color kcGreyLight = Color(0xffe5e5e5);
const Color kcGreyVeryLight = Color(0xFFF5F5F5);

final Widget horizontalSpaceTiny = SizedBox(width: 4.0);


