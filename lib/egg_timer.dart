import 'dart:async';

class EggTimer {
  EggTimerState state = EggTimerState.ready;
  final Duration maxTime;
  final Stopwatch stopwatch = Stopwatch();
  final Function onTimerUpdate;
  Duration _currentTime = const Duration(seconds: 0);
  Duration lasetStartTime = const Duration(seconds: 0);

  EggTimer({
    this.maxTime,
    this.onTimerUpdate,
  });

  get currentTime {
    return _currentTime;
  }

  set currentTime(newTime) {
    if (state == EggTimerState.ready) {
      _currentTime = newTime;
      lasetStartTime = currentTime;
    }
  }

  resume() {
    state = EggTimerState.running;
    lasetStartTime = _currentTime;
    stopwatch.start();
    _tick();
  }

  _tick() {
    _currentTime = lasetStartTime - stopwatch.elapsed;

    print('Current Time : ${_currentTime.inSeconds}');
    if (_currentTime.inSeconds > 0) {
      Timer(const Duration(seconds: 1), _tick);
    } else {
      state = EggTimerState.ready;
    }
    if (null != onTimerUpdate) {
      onTimerUpdate();
    }
  }

  pause() {}
}

enum EggTimerState {
  ready,
  running,
  paused,
}
