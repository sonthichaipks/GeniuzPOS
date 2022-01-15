import 'package:flutter/material.dart';
import 'dart:async';

typedef DateTime TimerGenerator(DateTime now);

class PosTimerBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final TimerGenerator generator;

  PosTimerBuilder({
    @required this.generator,
    @required this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    return _TimerBuilderState();
  }

  PosTimerBuilder.periodic(
    Duration interval, {
    Duration alignment,
    @required this.builder,
  }) : this.generator = periodicTimer(interval,
            alignment: alignment ?? getAlignmentUnit(interval));

  PosTimerBuilder.scheduled(
    Iterable<DateTime> schedule, {
    @required this.builder,
  }) : this.generator = scheduledTimer(schedule);
}

class _TimerBuilderState extends State<PosTimerBuilder> {
  Stream<DateTime> stream;
  Completer completer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, _) => widget.builder(context),
    );
  }

  @override
  void didUpdateWidget(PosTimerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cancel();
    _init();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _cancel();
  }

  _init() {
    completer = Completer();
    stream = createTimerStream(widget.generator, completer.future);
  }

  _cancel() {
    completer.complete();
  }
}

TimerGenerator periodicTimer(Duration interval,
    {Duration alignment = Duration.zero}) {
  assert(interval > Duration.zero);

  DateTime next;
  return (DateTime now) {
    next = alignDateTime((next ?? now).add(interval), alignment);
    if (now.compareTo(next) < 0) {
      next = alignDateTime(now.add(interval), alignment);
    }
    return next;
  };
}

TimerGenerator scheduledTimer(Iterable<DateTime> schedule) {
  List<DateTime> sortedSpecific = schedule.toList(growable: false);
  sortedSpecific.sort((a, b) => a.compareTo(b));
  return fromIterable(sortedSpecific);
}

TimerGenerator fromIterable(Iterable<DateTime> iterable) {
  final iterator = iterable.iterator;
  return (DateTime now) {
    return iterator.moveNext() ? iterator.current : null;
  };
}

Stream<DateTime> createTimerStream(
  TimerGenerator generator,
  Future stopSignal,
) async* {
  for (var now = DateTime.now(), next = generator(now);
      next != null;
      now = DateTime.now(), next = generator(now)) {
    if (now.compareTo(next) > 0) continue;
    Duration waitTime = next.difference(now);
    try {
      await stopSignal.timeout(waitTime);
      return;
    } on TimeoutException catch (_) {
      yield next;
    }
  }
}

Duration getAlignmentUnit(Duration interval) {
  return Duration(
    days: interval.inDays > 0 ? 1 : 0,
    hours: interval.inDays == 0 && interval.inHours > 0 ? 1 : 0,
    minutes: interval.inHours == 0 && interval.inMinutes > 0 ? 1 : 0,
    seconds: interval.inMinutes == 0 && interval.inSeconds > 0 ? 1 : 0,
    milliseconds:
        interval.inSeconds == 0 && interval.inMilliseconds > 0 ? 1 : 0,
    microseconds:
        interval.inMilliseconds == 0 && interval.inMicroseconds > 0 ? 1 : 0,
  );
}

DateTime alignDateTime(DateTime dt, Duration alignment,
    [bool roundUp = false]) {
  assert(alignment >= Duration.zero);
  if (alignment == Duration.zero) return dt;
  final correction = Duration(
      days: 0,
      hours: alignment.inDays > 0
          ? dt.hour
          : alignment.inHours > 0
              ? dt.hour % alignment.inHours
              : 0,
      minutes: alignment.inHours > 0
          ? dt.minute
          : alignment.inMinutes > 0
              ? dt.minute % alignment.inMinutes
              : 0,
      seconds: alignment.inMinutes > 0
          ? dt.second
          : alignment.inSeconds > 0
              ? dt.second % alignment.inSeconds
              : 0,
      milliseconds: alignment.inSeconds > 0
          ? dt.millisecond
          : alignment.inMilliseconds > 0
              ? dt.millisecond % alignment.inMilliseconds
              : 0,
      microseconds: alignment.inMilliseconds > 0 ? dt.microsecond : 0);
  if (correction == Duration.zero) return dt;
  final corrected = dt.subtract(correction);
  final result = roundUp ? corrected.add(alignment) : corrected;
  return result;
}
