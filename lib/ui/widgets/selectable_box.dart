part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final Widget text;
  final bool isSelected;
  final Color activeColor;
  final Color disabledColor;
  final Function onTap;
  final double width;
  final double height;
  final double borderRadius;

  const SelectableBox(
      {Key key,
      this.text,
      this.isSelected,
      this.activeColor,
      this.disabledColor,
      this.onTap,
      this.width = 100,
      this.height = 20,
      this.borderRadius = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: black),
          borderRadius: BorderRadius.circular(borderRadius),
          color: (isSelected) ? activeColor : disabledColor,
          shape: BoxShape.rectangle,
        ),
        child: text,
      ),
    );
  }
}
