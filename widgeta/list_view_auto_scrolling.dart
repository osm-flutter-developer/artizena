
import 'dart:async';

import 'package:flutter/material.dart';


class ListViewAutoScrolling extends StatefulWidget {
  final int itemsCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Axis scrollDirection;
  final Size itemSize;
  final Duration timerDuration;
  final Duration scrollDuration;
  final int? scrollingItemsCount;

  const ListViewAutoScrolling({super.key,
    required this.itemsCount,
    required this.itemBuilder,
    required this.itemSize,
    this.scrollDirection = Axis.horizontal,
    this.timerDuration = const Duration(seconds: 5),
    this.scrollDuration = const Duration(milliseconds: 1000),
    this.scrollingItemsCount,
  });

  @override
  State<ListViewAutoScrolling> createState() => _ListViewAutoScrollingState();

}

class _ListViewAutoScrollingState extends State<ListViewAutoScrolling> {
  final ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0;
  late int _itemsCount, _scrollingItemsCount = 1;
  late PausableTimer _timer;
  late Duration _timerDuration, _scrollDuration;

  double get itemHeight => widget.scrollDirection == Axis.horizontal ? widget.itemSize.width : widget.itemSize.height;
  double get scrollingItemsHeight => itemHeight * _scrollingItemsCount;

  @override
  void initState() {
    super.initState();
    _itemsCount = widget.itemsCount;
    _timerDuration = widget.timerDuration;
    _scrollDuration = widget.scrollDuration;
    _timer = PausableTimer(_timerDuration, _onTimerCallBack);
    _timer.start();
  }

  void _onTimerCallBack(Timer timer) async {
    if(!_scrollController.hasClients) return;
    final maxScrolling = _scrollPosition < 0 ? _scrollController.position.minScrollExtent : _scrollController.position.maxScrollExtent;
    // print('scroll position: $_scrollPosition, maxScrolling: $maxScrolling, itemsCanScroll: $_scrollingItemsCount, newPosition: ${scrollingItemsHeight + _scrollPosition}');
    if(_scrollPosition + scrollingItemsHeight < maxScrolling) {
      _scrollPosition += scrollingItemsHeight;
    } else {
      if(maxScrolling - _scrollPosition != 0.0) {
        _scrollPosition += maxScrolling - _scrollPosition;
      } else {
        _scrollPosition *= -1;
      }
    }
    _scrollController.animateTo(_scrollPosition < 0.0 ? _scrollPosition * -1 : _scrollPosition, duration: _scrollDuration, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant ListViewAutoScrolling oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.itemsCount != oldWidget.itemsCount) {
      _itemsCount = widget.itemsCount;
    }
    if(widget.timerDuration.inSeconds != oldWidget.timerDuration.inSeconds) {
      _timerDuration = widget.timerDuration;
      _timer.cancel();
      _timer = PausableTimer(_timerDuration, _onTimerCallBack);
    }
    if(widget.scrollDuration.inSeconds != oldWidget.scrollDuration.inSeconds) {
      _scrollDuration = widget.scrollDuration;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    _timer.pause();
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    _timer.start();
  }

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.width / itemHeight).toInt();
    _scrollingItemsCount = widget.scrollingItemsCount ?? (size < 1 ? 1 : size);
    if(_scrollingItemsCount < 1) _scrollingItemsCount = 1;
    return ListView.builder(
      itemCount: _itemsCount,
      itemBuilder: (context, index) {
        return SizedBox(
          width: widget.itemSize.width,
          height: widget.itemSize.height,
          child: widget.itemBuilder(context, index),
        );
      },
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      // separatorBuilder: (_, index) {
      //   return SizedBox(
      //     width: widget.scrollDirection == Axis.horizontal ? 25 : null,
      //     height: widget.scrollDirection == Axis.vertical ? 25 : null,
      //   );
      // },
    );
  }
}


class PausableTimer {
  Timer? _timer;
  Duration _remaining;
  DateTime? _startTime;
  final void Function(Timer timer) _callback;

  PausableTimer(this._remaining, this._callback);

  void start() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(_remaining, _callback);
  }

  void pause() {
    if(_timer?.isActive ?? false) {
      _remaining -= DateTime.now().difference(_startTime!);
      _timer?.cancel();
    }
  }

  void cancel() => _timer?.cancel();



}