import 'package:flutter/material.dart';
import 'package:scoreboard_tn/constants.dart';

class Engine {
  Color colorTextLeft = Colors.black;
  Color colorBackgroundLeft = Colors.red;
  Color colorTextRight = Colors.black;
  Color colorBackgroundRight = Colors.blueAccent;

  String labelLeft = "Away";
  String labelRight = "Home";
  int valueLeft = 0;
  int valueRight = 0;

  String pendingLabelLeft = "";
  String pendingLabelRight = "";
  Color pendingColorTextLeft = Colors.black;
  Color pendingColorBackgroundLeft = Colors.red;
  Color pendingColorTextRight = Colors.black;
  Color pendingColorBackgroundRight = Colors.blueAccent;

  FontTypes fontType = FontTypes.system;

  bool forceLandscape = true;
  bool notify7Enabled = false;
  bool notify8Enabled = false;
  bool lastPointLeft = false;
  bool lastPointEnabled = true;

  Engine();

  //
  // pack/unpack
  //
  String pack() {
    String result = "";

    // result += colorTextLeft.toString() + ";";
    // result += colorBackgroundLeft.toString() + ";";
    // result += colorTextRight.toString() + ";";
    // result += colorBackgroundRight.toString() + ";";

    // result += labelLeft.toString() + ";";
    // result += labelRight.toString() + ";";
    // result += valueLeft.toString() + ";";
    // result += valueRight.toString() + ";";

    // result += "removed" + ";";
    // result += "removed" + ";";
    // result += "removed" + ";";
    // result += "removed" + ";";

    // result += fontType.toString() + ";";

    // result += forceLandscape.toString() + ";";
    // result += notify7Enabled.toString() + ";";
    // result += notify8Enabled.toString() + ";";

    // result += lastPointLeft.toString() + ";";
    // result += lastPointEnabled.toString() + ";";

    return result;
  }

  Color stringToColor(String code) {
    // .... Color(0xff000000)
    var parts = code.split("0x");
    var s = parts[1].substring(0, 8);
    var h = int.parse(s, radix: 16);
    return new Color(h);
  }

  void unpack(String packed) {
    // if (packed.length == 0)
    //   return;

    // var parts = packed.split(";");
    // int index = 0;

    // colorTextLeft = stringToColor(parts[index++]);
    // colorBackgroundLeft = stringToColor(parts[index++]);
    // colorTextRight = stringToColor(parts[index++]);
    // colorBackgroundRight = stringToColor(parts[index++]);

    // labelLeft = parts[index++];
    // labelRight = parts[index++];
    // valueLeft = int.parse(parts[index++]);
    // valueRight = int.parse(parts[index++]);

    // index++;
    // index++;
    // index++;
    // index++;

    // fontType = FontTypes.system;
    // for (var value in FontTypes.values) {
    //   if (value.toString() == parts[index]) {
    //     fontType = value;
    //     break;
    //   }
    // }
    // index++;

    // forceLandscape = parts[index++] == "true";
    // notify7Enabled = parts[index++] == "true";
    // notify8Enabled = parts[index++] == "true";

    // lastPointLeft = parts[index++] == "true";
    // lastPointEnabled = parts[index++] == "true";

    // colorTextLeft = colorTextLeft;
    // colorBackgroundLeft = colorBackgroundLeft;
    // colorTextRight = colorTextRight;
    // colorBackgroundRight = colorBackgroundRight;

    // pendingColorTextLeft = colorTextLeft;
    // pendingColorBackgroundLeft = colorBackgroundLeft;
    // pendingColorTextRight = colorTextRight;
    // pendingColorBackgroundRight = colorBackgroundRight;

  }

  //
  // Public methods
  //

  String getLabelLeft() {
    String result = labelLeft;
    if (lastPointEnabled) {
      if ((valueLeft > 0 || valueRight > 0) && lastPointLeft) {
        result = labelLeft + " >";
      }
    }
    return result;
  }

  String getLabelRight() {
    String result = labelRight;
    if (lastPointEnabled) {
      if ((valueLeft > 0 || valueRight > 0) && !lastPointLeft) {
        result = "< " + labelRight;
      }
    }
    return result;
  }

  void incrementLeft() {
    valueLeft += 1;
    lastPointLeft = true;
  }

  void decrementLeft() {
    valueLeft -= 1;
    if (valueLeft < 0) valueLeft = 0;
  }

  void incrementRight() {
    valueRight += 1;
    lastPointLeft = false;
  }

  void decrementRight() {
    valueRight -= 1;
    if (valueRight < 0) valueRight = 0;
  }

  void clearBoth() {
    valueLeft = 0;
    valueRight = 0;
    lastPointLeft = false;
  }

  void resetBoth()  {
    labelLeft = "Away";
    labelRight = "Home";
    valueLeft = 0;
    valueRight = 0;
    lastPointLeft = false;
    colorTextLeft = Colors.black;
    colorBackgroundLeft = Colors.red;
    colorTextRight = Colors.black;
    colorBackgroundRight = Colors.blueAccent;
    pendingColorTextLeft = colorTextLeft;
    pendingColorBackgroundLeft = colorBackgroundLeft;
    pendingColorTextRight = colorTextRight;
    pendingColorBackgroundRight = colorBackgroundRight;
    fontType = FontTypes.system;
  }

  void swapTeams() {
    var valueTemp = valueLeft;
    valueLeft = valueRight;
    valueRight = valueTemp;
    lastPointLeft = !lastPointLeft;
    var labelTemp = labelLeft;
    labelLeft = labelRight;
    labelRight = labelTemp;
    var colorTemp = colorTextLeft;
    colorTextLeft = colorTextRight;
    colorTextRight = colorTemp;
    colorTemp = colorBackgroundLeft;
    colorBackgroundLeft = colorBackgroundRight;
    colorBackgroundRight = colorTemp;
  }

  void savePending() {
    labelLeft = pendingLabelLeft;
    labelRight = pendingLabelRight;
    colorTextLeft = pendingColorTextLeft;
    colorBackgroundLeft = pendingColorBackgroundLeft;
    colorTextRight = pendingColorTextRight;
    colorBackgroundRight = pendingColorBackgroundRight;
  }

  void setPending() {
    pendingLabelLeft = labelLeft;
    pendingLabelRight = labelRight;
    pendingColorTextLeft = colorTextLeft;
    pendingColorBackgroundLeft = pendingColorBackgroundLeft;
    pendingColorBackgroundRight = pendingColorBackgroundRight;
  }

  bool notify7() {
    if (notify7Enabled) {
      if (((valueLeft + valueRight) % 7) == 0)
        return true;
    }
    return false;
  }

  bool notify8() {
    if (notify8Enabled) {
      if (valueLeft == 8 || valueRight == 8)
        return true;
    }
    return false;
  }
}
