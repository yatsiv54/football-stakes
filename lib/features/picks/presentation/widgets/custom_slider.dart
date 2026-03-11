import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeEnd;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final bool showLabels;
  final bool showValue;
  final String Function(double)? valueFormatter;

  const CustomSlider({
    super.key,
    required this.value,
    this.min = 1.0,
    this.max = 5.0,
    this.divisions,
    this.onChanged,
    this.onChangeEnd,
    required this.activeColor,
    this.inactiveColor = const Color(0xFF2A2A2A),
    this.thumbColor = Colors.white,
    this.showLabels = true,
    this.showValue = true,
    this.valueFormatter,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _currentValue = widget.value;
    }
  }

  String _formatValue(double value) {
    if (widget.valueFormatter != null) {
      return widget.valueFormatter!(value);
    }
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            SliderTheme(
              data: SliderThemeData(
                tickMarkShape: SliderTickMarkShape.noTickMark,
                trackHeight: 20,
                thumbShape: CustomThumbShape(
                  thumbRadius: 10,
                  thumbColor: Colors.white,
                ),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                activeTrackColor: widget.activeColor,
                inactiveTrackColor: widget.inactiveColor,
                thumbColor: widget.thumbColor,
                trackShape: CustomTrackShape(),
              ),
              child: Slider(
                value: _currentValue,
                min: widget.min,
                max: widget.max,

                divisions: 4,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                  widget.onChanged?.call(value);
                },
                onChangeEnd: widget.onChangeEnd,
              ),
            ),

            if (widget.showValue)
              Positioned(
                left: _getThumbPosition(),
                top: 40,
                child: CustomValueBubble(
                  value: _formatValue(_currentValue),
                  color: widget.activeColor,
                ),
              ),
          ],
        ),

        if (widget.showLabels)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentValue == 1
                    ? SizedBox.shrink()
                    : Text(
                        _formatValue(widget.min),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                _currentValue == 5
                    ? SizedBox.shrink()
                    : Text(
                        _formatValue(widget.max),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ],
            ),
          ),
      ],
    );
  }

  double _getThumbPosition() {
    final percentage = (_currentValue - widget.min) / (widget.max - widget.min);
    final sliderWidth = MediaQuery.of(context).size.width - 40;
    return 12 + (sliderWidth * percentage) - 16;
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 8;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbColor;

  const CustomThumbShape({
    this.thumbRadius = 12,
    this.thumbColor = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    final innerPaint = Paint()
      ..color = MyColors.yellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius - 5, innerPaint);
  }
}

class CustomValueBubble extends StatelessWidget {
  final String value;
  final Color color;

  const CustomValueBubble({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: MyColors.yellow,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(value, style: MyStyles.medium),
    );
  }
}
