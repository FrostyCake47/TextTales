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

const Gradient configCardInnerGradient = LinearGradient(
  colors: [Color(0xff8E9D32), Color(0xff1B934B)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.centerLeft,
  end: FractionalOffset.centerRight,
  tileMode: TileMode.repeated
);

const Gradient configCardOuterGradient = LinearGradient(
  colors: [Color(0xffF0F4E0), Color(0xffE7FFEA)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient playerCardReady = LinearGradient(
  colors: [Color.fromARGB(255, 130, 190, 90), Color.fromARGB(255, 201, 255, 209)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient playerCardNotReady = LinearGradient(
  colors: [Color.fromARGB(255, 202, 88, 99),Color.fromARGB(255, 223, 140, 80)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient playerCardNotStart = LinearGradient(
  colors: [Color.fromARGB(255, 57, 57, 57),Color.fromARGB(255, 151, 151, 151)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient submitButtonGradient = LinearGradient(
  colors: [Color.fromARGB(255, 211, 34, 81),Color.fromARGB(255, 255, 174, 53)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);

const Gradient submittedButtonGradient = LinearGradient(
  colors: [Color.fromARGB(255, 97, 73, 79),Color.fromARGB(255, 150, 132, 104)],
  stops: [0.0, 1.0],
  begin: FractionalOffset.topLeft,
  end: FractionalOffset.bottomRight,
  tileMode: TileMode.repeated
);