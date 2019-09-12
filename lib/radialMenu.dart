import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians, Vector3;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox.expand(child: RadialMenu()),
    );
  }
}

double dx = 0;
double dy = 0;

class RadialMenu extends StatefulWidget {
  // final double height;
  // final double weight;
  // const RadialMenu(
  //     {this.height = double.infinity, this.weight = double.infinity});

  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    animation = Tween<Offset>(
      begin: Offset(dx, dy),
      end: Offset(dx, dy),
    ).animate(controller);
    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2;
    final width = MediaQuery.of(context).size.width / 2;
    return GestureDetector(
      child: RadialAnimation(controller: controller, animation: animation),
      onHorizontalDragUpdate: (DragUpdateDetails update) {
        setState(() {
          dx = update.globalPosition.dx -width ;
          dy = update.globalPosition.dy-height ;
        });
        print(height);
        print(width);

        print(update.globalPosition);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key, this.controller, this.animation})
      : translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<Offset> animation;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, widget) {
          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: <Widget>[
                _buildButton(0,
                    color: Colors.red, icon: FontAwesomeIcons.thumbtack),
                _buildButton(45,
                    color: Colors.green, icon: FontAwesomeIcons.sprayCan),
                _buildButton(90,
                    color: Colors.orange, icon: FontAwesomeIcons.fire),
                _buildButton(135,
                    color: Colors.blue, icon: FontAwesomeIcons.kiwiBird),
                _buildButton(180,
                    color: Colors.black, icon: FontAwesomeIcons.cat),
                _buildButton(225,
                    color: Colors.indigo, icon: FontAwesomeIcons.paw),
                _buildButton(270,
                    color: Colors.pink, icon: FontAwesomeIcons.bong),
                _buildButton(315,
                    color: Colors.yellow, icon: FontAwesomeIcons.bolt),
                Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                      child: Icon(FontAwesomeIcons.timesCircle),
                      onPressed: _close,
                      backgroundColor: Colors.red),
                ),
                Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                      child: Icon(FontAwesomeIcons.solidDotCircle),
                      onPressed: _open),
                ),
              ]),
            ),
          );
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }

//  buildScaledContainer() {
//    return
//  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);

    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            child: Icon(icon),
            backgroundColor: color,
            onPressed: _close,
            elevation: 0));
  }
}
