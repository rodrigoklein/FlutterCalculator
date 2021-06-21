import 'package:flutter/material.dart';
import 'button.dart';
import 'button_row.dart';

class Keyboard extends StatelessWidget {
  // const Keyboard({ Key? key }) : super(key: key);

  final void Function(String) cb;

  Keyboard(this.cb);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: <Widget>[
          new ButtonRow([
            new Button.big(text: 'AC', color: Button.DARK, cb: cb),
            new Button(text: '%', color: Button.DARK, cb: cb),
            new Button.operation(text: '/', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          new ButtonRow([
            new Button(text: '7', cb: cb),
            new Button(text: '8', cb: cb),
            new Button(text: '9', cb: cb),
            new Button.operation(text: 'X', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          new ButtonRow([
            new Button(text: '4', cb: cb),
            new Button(text: '5', cb: cb),
            new Button(text: '6', cb: cb),
            new Button.operation(text: '-', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          new ButtonRow([
            new Button(text: '1', cb: cb),
            new Button(text: '2', cb: cb),
            new Button(text: '3', cb: cb),
            new Button.operation(text: '+', cb: cb),
          ]),
          SizedBox(
            height: 1,
          ),
          new ButtonRow([
            new Button(text: '0', big: true, cb: cb),
            new Button(text: '.', cb: cb),
            new Button.operation(text: '=', cb: cb),
          ])
        ],
      ),
    );
  }
}
