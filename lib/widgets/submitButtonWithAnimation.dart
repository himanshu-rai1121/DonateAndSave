import 'package:flutter/material.dart';

class CustomMainButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String buttonName;

  CustomMainButton({required this.onPressed, required this.buttonName});

  @override
  _CustomMainButtonState createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          Duration(milliseconds: 100), // Faster animation: 100 milliseconds
    );
    _animation = Tween<double>(
            begin: 1.0, end: 0.95) // Decreased depth: from 0.85 to 0.95
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((value) => _controller.reverse());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.translucent,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(25), // Decreased depth: from 30 to 25
            gradient: LinearGradient(
              colors: [
                Colors.orangeAccent,
                Colors.yellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              widget.buttonName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
