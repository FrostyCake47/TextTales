import 'package:flutter/material.dart';


const light = Color(0xffF0EFF4);
const dark = Color(0xff0C0C0C);
const primaryColor = Color(0xffDA4167);
const secondaryColor = Color(0xff832161);
const tertiaryColor = Color(0xff3D2645);

const Gradient bgGradient = LinearGradient(
  colors: [Color(0xff2A1446), Color(0xff9648D4), Color(0xff75D6FF), Color(0xff427498)],
  stops: [0.0, 0.30, 0.8, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient homebtnGradient = LinearGradient(
  colors: [Color(0xffF1DAFF), Color(0xffBBF2FE)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);