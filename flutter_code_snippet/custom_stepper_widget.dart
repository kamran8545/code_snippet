/// In this Stepper stepper icon will be palced at the middle of item


import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

@immutable
class ControlsDetails {
  const ControlsDetails({
    required this.currentStep,
    required this.stepIndex,
  });

  final int currentStep;

  final int stepIndex;

  bool get isActive => currentStep == stepIndex;
}

const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 7.0;

@immutable
class CustomStep {

  const CustomStep({
    required this.title,
    this.subtitle,
    required this.content,
    this.isActive = false,
    this.label,
  }) : assert(title != null),
        assert(content != null);

  final Widget title;

  final Widget? subtitle;

  final Widget content;

  final bool isActive;

  final Widget? label;
}

class CustomStepperWidget extends StatefulWidget {

  const CustomStepperWidget({
    super.key,
    required this.steps,
    this.physics,
    this.currentStep = 0,
    this.elevation,
    this.margin,
  }) : assert(steps != null),
        assert(currentStep != null),
        assert(0 <= currentStep && currentStep < steps.length);

  final List<CustomStep> steps;

  final ScrollPhysics? physics;

  final int currentStep;

  final double? elevation;

  final EdgeInsetsGeometry? margin;

  @override
  State<CustomStepperWidget> createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
          (int i) => GlobalKey(),
    );
  }

  @override
  void didUpdateWidget(CustomStepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildLine(bool visible) {
    return Container(
      margin: EdgeInsets.zero,
      constraints: BoxConstraints(
        minHeight: 8.0,
        maxHeight: 20
      ),
      width: visible ? 1.0 : 0.0,
      color: AppColors.mainButtonGradientStart,
    );
  }


  Widget _buildCircle(int index, bool oldState) {
    return Container(
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: AppColors.mainButtonGradientStart,
          shape: BoxShape.circle,
        ),
        child: SizedBox.shrink(),
      ),
    );
  }

  Widget _buildIcon(int index) {
    return _buildCircle(index, true);
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    return textTheme.bodyLarge!.copyWith(
      color: _isDark() ? _kDisabledDark : _kDisabledLight,
    );
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    return textTheme.bodySmall!.copyWith(
      color: _isDark() ? _kDisabledDark : _kDisabledLight,
    );
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildLine(!_isFirst(index)),
              _buildIcon(index),
              _buildLine(!_isLast(index)),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 12.0),
              child: _buildHeaderText(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: 24.0,
          top: 0.0,
          bottom: 0.0,
          child: SizedBox(
            width: 24.0,
            child: Center(
              child: SizedBox(
                width: _isLast(index) ? 0.0 : 1.0,
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: Container(
            margin: widget.margin ?? const EdgeInsetsDirectional.only(
              start: 60.0,
              end: 24.0,
              bottom: 24.0,
            ),
            child: Column(
              children: <Widget>[
                widget.steps[index].content,
                // _buildVerticalControls(index),
              ],
            ),
          ),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration,
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: <Widget>[
        for (int i = 0; i < widget.steps.length; i += 1)
          Column(
            key: _keys[i],
            children: <Widget>[
              _buildVerticalHeader(i),
              _buildVerticalBody(i),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<CustomStepperWidget>() != null) {
        throw FlutterError(
          'Steppers must not be nested.\n'
              'The material specification advises that one should avoid embedding '
              'steppers within steppers. '
              'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      }
      return true;
    }());
    return _buildVertical();
  }
}
