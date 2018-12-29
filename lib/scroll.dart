import 'package:flutter/material.dart';

class ScrollButtonsWidget extends StatelessWidget {
  VoidCallback onPressedUp;
  VoidCallback onPressedDown;

  ScrollButtonsWidget({this.onPressedUp, this.onPressedDown});

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new IconButton(
          tooltip: 'Scroll up',
          icon: Icon(Icons.arrow_drop_up),
          iconSize: 32,
          onPressed: onPressedUp
        ),
        new IconButton(
          tooltip: 'Scroll down',
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 32,
          onPressed: onPressedDown
        )
      ],
    );
  }
}

class ListViewWithScroll extends StatefulWidget {
  ListViewWithScroll({
    this.children
  });

  List<Widget> children = [];

  @override
  _ListViewWithScrollState createState() =>
      _ListViewWithScrollState(children: this.children);
}

class _ListViewWithScrollState extends State<ListViewWithScroll> {
  _ListViewWithScrollState({
    this.children
  });

  ScrollController _controller;
  List<Widget> children = [];

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _moveUp() {
    _controller.animateTo(
      _controller.offset - 100,
      curve: Curves.linear,
      duration: Duration(milliseconds: 500)
    );
  }

  _moveDown() {
    _controller.animateTo(
      _controller.offset + 100,
      curve: Curves.linear,
      duration: Duration(milliseconds: 500)
    );
  }

  @override
  Widget build(BuildContext context) {
    print('>>> Children: ${this.children}');

    return new Scrollbar(
      child: new Row(
        children: [
          new Expanded(
            child: new ListView(
              controller: _controller,
              children: this.children
            )
          ),
          new ScrollButtonsWidget(
            onPressedUp: this._moveUp,
            onPressedDown: this._moveDown
          ),
        ]
      )
    );
  }
}