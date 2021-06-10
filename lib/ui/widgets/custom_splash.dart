part of 'widgets.dart';

class CustomSplash extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 80);
    var controlPoint1 = Offset(size.width / 4, size.height);
    var point1 = Offset(size.width / 2, size.height);
    var controlPoint2 = Offset(size.width - (size.width / 4), size.height);
    var point2 = Offset(size.width, size.height - 80);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, point1.dx, point1.dy);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, point2.dx, point2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
