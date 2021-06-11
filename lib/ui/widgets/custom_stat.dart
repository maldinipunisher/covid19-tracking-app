part of 'widgets.dart';

class CustomStats extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - (size.height * 80 / 100));
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - (size.height * 80 / 100));
    path.quadraticBezierTo(
        size.width,
        size.height - (size.height * 90 / 100),
        size.width - (size.width * 5 / 100),
        size.height - (size.height * 90 / 100));

    path.quadraticBezierTo(
        size.width / 2,
        0,
        size.width - (size.width * 95 / 100),
        size.height - (size.height * 90 / 100));

    path.quadraticBezierTo(0, size.height - (size.height * 90 / 100), 0,
        size.height - (size.height * 80 / 100));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
