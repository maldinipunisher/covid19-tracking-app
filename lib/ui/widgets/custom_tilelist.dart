part of "widgets.dart";

class CustomTileList extends StatelessWidget {
  final double width;
  final double height;
  final Widget title;
  final Widget heading;
  final Widget leading;
  final Widget action;
  final Widget icon;
  final double padding;

  const CustomTileList(
      {Key key,
      @required this.width,
      @required this.height,
      this.title,
      this.heading,
      this.leading,
      this.action,
      this.icon,
      this.padding = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 0.1)),
      child: Column(children: [
        if (title != null || icon != null)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [if (title != null) title, if (icon != null) icon],
            ),
          ),
        if (heading != null) Expanded(child: heading),
        if (leading != null || action != null)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (leading != null) leading,
                if (action != null) action
              ],
            ),
          )
      ]),
    );
  }
}
