import 'package:flutter/material.dart';

class CustomZoomWidget extends StatefulWidget {
  final Widget child;
  const CustomZoomWidget({Key? key,required this.child}) : super(key: key);

  @override
  State<CustomZoomWidget> createState() => _CustomZoomWidgetState();
}

class _CustomZoomWidgetState extends State<CustomZoomWidget> with SingleTickerProviderStateMixin{
  late TransformationController _transformationController;
  late TapDownDetails _tapDownDetails;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200)
    )..addListener(() {
      _transformationController.value = _animation.value;
    });
  }


  @override
  void dispose() {
    super.dispose();
    _transformationController.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details)=>_tapDownDetails = details,
      onDoubleTap: (){
        final position = _tapDownDetails.localPosition;
        const double scale = 4; //It means 400 percent
        final x = -position.dx * (scale-1);
        final y = -position.dy * (scale-1);

        final zoomed = Matrix4.identity()
          ..translate(x,y)
          ..scale(scale);
        final end = _transformationController.value.isIdentity()
            ? zoomed:Matrix4.identity();

        _animation = Matrix4Tween(
          begin: _transformationController.value,
          end: end
        ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController));

        _animationController.forward(from: 0);
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
          // clipBehavior: Clip.none,
          panEnabled: true,
          scaleEnabled: true,
          child: widget.child,
      ),
    );
  }
}
