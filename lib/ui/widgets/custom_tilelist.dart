part of 'widgets.dart';

class CustomTileList extends StatefulWidget {
  final String title;
  final Widget icon;
  final Widget leading;
  final Widget subtitle;
  final double width, height;
  final List<int> chartValue;

  CustomTileList(
      {Key key,
      this.title,
      this.icon,
      this.leading,
      this.subtitle,
      this.width,
      this.height,
      this.chartValue})
      : super(key: key);

  final availableColors = [
    white,
    lightBlue1,
    lightBlue2,
    lightBlue3,
    salmon,
    blue
  ];

  @override
  _CustomTileListState createState() => _CustomTileListState();
}

class _CustomTileListState extends State<CustomTileList> {
  num chartMin;
  num chartMax;
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    chartMin = widget.chartValue.cast<num>().reduce(min);
    chartMin = widget.chartValue.cast<num>().reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      width: (widget.width < 60)
          ? throw Exception('height cannot less than 100')
          : widget.width,
      height: (widget.height < 60)
          ? throw Exception('height cannot less than 100')
          : widget.height,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.height * 10 / 100,
            horizontal: widget.width * 10 / 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.title,
                    style: titleTextStyle.copyWith(
                      color: black,
                    )),
                widget.icon,
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                margin: EdgeInsets.symmetric(
                    vertical: widget.height * 3 / 100,
                    horizontal: widget.width * 3 / 100),
                padding: EdgeInsets.symmetric(
                    vertical: widget.height * 10 / 100,
                    horizontal: widget.width * 10 / 100),
                child: BarChart(
                  mainBarData(),
                  swapAnimationDuration: animDuration,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: widget.height * 3 / 100,
                  horizontal: widget.width * 3 / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [widget.leading, widget.subtitle],
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor = salmon;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(widget.chartValue.length, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.chartValue[i].toDouble(),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
