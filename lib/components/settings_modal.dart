import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class SettingsModal extends StatefulWidget {
  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;

  SettingsModal(
      BuildContext context,
      Engine engine,
      Function onReset,
      Function onClear,
      Function onSwap,
      Function onDone
      ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
  }

  @override
  _SettingsModal createState() => _SettingsModal(context, engine, onReset, onClear, onSwap, onDone);
}

class _SettingsModal extends State<SettingsModal> {

  _SettingsModal(
      BuildContext context,
      Engine engine,
      Function onReset,
      Function onClear,
      Function onSwap,
      Function onDone
      ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
    this._newColorTextLeft = this.engine.pendingColorTextLeft;
    this._newColorBackgroundLeft = this.engine.pendingColorBackgroundLeft;
    this._newColorTextRight = this.engine.pendingColorTextRight;
    this._newColorBackgroundRight = this.engine.pendingColorBackgroundRight;

  }

  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;

  late Color _newColorTextLeft;
  late Color _newColorBackgroundLeft;
  late Color _newColorTextRight;
  late Color _newColorBackgroundRight;

  //late var selectedFont = "";
  //late List<String> allFonts;


  late var selectedRate;
  late List<String> allRates;


  void _fromEngine() async {
    setState(() {
      this._newColorTextLeft = this.engine.pendingColorTextLeft;
      this._newColorBackgroundLeft = this.engine.pendingColorBackgroundLeft;
      this._newColorTextRight = this.engine.pendingColorTextRight;
      this._newColorBackgroundRight = this.engine.pendingColorBackgroundRight;
    });
  }

  void _onColorTextLeftChanged(Color color) {
    this.engine.pendingColorTextLeft = color;
    _fromEngine();
  }

  void _onColorBackgroundLeftChanged(Color color) {
    this.engine.pendingColorBackgroundLeft = color;
    _fromEngine();
  }

  void _onColorTextRightChanged(Color color) {
    this.engine.pendingColorTextRight = color;
    _fromEngine();
  }

  void _onColorBackgroundRightChanged(Color color) {
    this.engine.pendingColorBackgroundRight = color;
    _fromEngine();
  }

  void colorTextLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _newColorTextLeft,
              onColorChanged: _onColorTextLeftChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorBackgroundLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _newColorBackgroundLeft,
              onColorChanged: _onColorBackgroundLeftChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorTextRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _newColorTextRight,
              onColorChanged: _onColorTextRightChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorBackgroundRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _newColorBackgroundRight,
              onColorChanged: _onColorBackgroundRightChanged,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void fontChanged(FontTypes fontType) async {
    this.engine.fontType = fontType;
    Navigator.of(context).pop();
    this.onDone();
  }

  void onFontChange() async {
    List<Widget> widgets = [];
    for (var value in FontTypes.values) {
      var style = getLabelFont(value);
      var tile = new ListTile(
                    title: new Text(
                      getFontString(value),
                      style: style.copyWith(fontSize: kSettingsTextStyle_fontSize),
                    ),
                    onTap: () => fontChanged(value),
                    trailing: new Icon(engine.fontType == value ? Icons.check : null),
                  );
      widgets.add(tile);
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kSettingsModalBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            toolbarHeight: 50,
            titleSpacing: 20,
            title: Text("Settings"),
            actions: [],
          ),
          body: Container(
              child: ListView(
                children: widgets,
              ),
            ),
          // context,
          // this._engine,
          // _resetBoth,
          // _clearBoth,
          // _swapTeams,
          // _saveBoth,
        );
      },
      isScrollControlled: true,
    );
  }


  void onForceLandscapeChanged() async {
    if (!this.engine.forceLandscape) {
      this.engine.forceLandscape = true;
    } else {
      this.engine.forceLandscape = false;
    }
    this.onDone();
  }

  void onLastPointChanged() async {
    if (!this.engine.lastPointEnabled) {
      this.engine.lastPointEnabled = true;
    } else {
      this.engine.lastPointEnabled = false;
    }
    this.onDone();
  }

  void onNotify7EnabledChanged() async {
    if (!this.engine.notify7Enabled) {
      this.engine.notify7Enabled = true;
    } else {
      this.engine.notify7Enabled = false;
    }
    this.onDone();
  }

  void onNotify8EnabledChanged() async {
    if (!this.engine.notify8Enabled) {
      this.engine.notify8Enabled = true;
    } else {
      this.engine.notify8Enabled = false;
    }
    this.onDone();
  }


  void onHelp() async {
    launch('https://github.com/alpiepho/scoreboard_tn/blob/master/README.md');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var fontString = getFontString(engine.fontType);
    var fontStyle = getLabelFont(engine.fontType);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kSettingsModalBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 20,
        title: Text(
          "Settings",
          style: kSettingsTextEditStyle,
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Divider(),
            new ListTile(
              title: new Text(
                'Swap.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSwap as void Function()?,
            ),
            new ListTile(
              title: new Text(
                'Clear Scores.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onClear as void Function()?,
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Reset All.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onReset as void Function()?,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Name',
                ),
                autofocus: false,
                initialValue: engine.labelLeft,
                onChanged: (text) => engine.pendingLabelLeft = text,
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              title: new Text(
                'Text Color...',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: _newColorTextLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextLeftEdit,
            ),
            new ListTile(
              title: new Text(
                'Background Color...',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: _newColorBackgroundLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundLeftEdit,
            ),
            Divider(),
            new ListTile(
                leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Name'
                ),
                autofocus: false,
                initialValue: engine.labelRight,
                onChanged: (text) => engine.pendingLabelRight = text,
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.edit),
           ),
            new ListTile(
              title: new Text(
                'Text Color...',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: _newColorTextRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextRightEdit,
            ),
            new ListTile(
              title: new Text(
                'Background Color...',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: _newColorBackgroundRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundRightEdit,
            ),
            new ListTile(
              title: new Text(
                'Save Team Settings.',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onDone as void Function()?,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Force Landscape.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.forceLandscape ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onForceLandscapeChanged,
            ),
            new ListTile(
              title: new Text(
                'Last Point Marker.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.lastPointEnabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onLastPointChanged,
            ),
            new ListTile(
              title: new Text(
                'Notify at 7.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.notify7Enabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onNotify7EnabledChanged,
            ),
            new ListTile(
              title: new Text(
                'Notify at 8.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.notify8Enabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onNotify8EnabledChanged,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Change Fonts...',
                style: kSettingsTextEditStyle,
              ),
              onTap: onFontChange,
            ),
            new ListTile(
              title: new Text(
                fontString,
                style: fontStyle.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: onFontChange,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                kVersion,
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Help...',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.help),
              onTap: onHelp,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
          ],
        ),
      ),
    );
  }
}
