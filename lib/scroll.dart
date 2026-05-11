import 'package:flutter/material.dart';

class ScrollButtonsWidget extends StatelessWidget {
  final VoidCallback? onPressedUp;
  final VoidCallback? onPressedDown;

  const ScrollButtonsWidget({
    super.key,
    this.onPressedUp,
    this.onPressedDown,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          tooltip: 'Subir',
          icon: const Icon(Icons.arrow_drop_up),
          iconSize: 32,
          onPressed: onPressedUp,
        ),
        IconButton(
          tooltip: 'Bajar',
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 32,
          onPressed: onPressedDown,
        ),
      ],
    );
  }
}

class ListViewWithScroll extends StatefulWidget {
  final List<Widget> children;

  const ListViewWithScroll({super.key, required this.children});

  @override
  _ListViewWithScrollState createState() => _ListViewWithScrollState();
}

class _ListViewWithScrollState extends State<ListViewWithScroll> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _moveUp() => _controller.animateTo(
        _controller.offset - 100,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );

  void _moveDown() => _controller.animateTo(
        _controller.offset + 100,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Row(
        children: [
          Expanded(
            child: ListView(
              controller: _controller,
              children: widget.children,
            ),
          ),
          ScrollButtonsWidget(
            onPressedUp: _moveUp,
            onPressedDown: _moveDown,
          ),
        ],
      ),
    );
  }
}
