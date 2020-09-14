import 'package:flutter/material.dart';

class DragTokenPosition {
  double x;
  double y;

  get X => x;
  get Y => y;

  changePosition(Offset position) {
    this.x = position.dx;
    this.y = position.dy;
  }
}
