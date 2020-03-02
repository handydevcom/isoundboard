import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';

class FabActionButton extends SpeedDialChild {
  bool value;
  String textOn;
  String textOff;
  Icon iconOn;
  Icon iconOff;
  VoidCallback onClick;

  FabActionButton(
      {this.value,
      this.textOn,
      this.textOff,
      this.iconOn,
      this.iconOff,
      this.onClick});

  @override
  Widget get child => value ? iconOn : iconOff;

  @override
  String get label => value ? textOn : textOff;

  @override
  TextStyle get labelStyle => TextStyle(fontSize: 18.0, color: Colors.black);

  @override
  get onTap => () {
        Future.delayed(const Duration(milliseconds: 500), () {
          onClick();
        });
      };
}
