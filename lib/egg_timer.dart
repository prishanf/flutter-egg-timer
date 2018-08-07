class EggTimer{

  EggTimerState state = EggTimerState.ready;
  final Duration maxTime;
  Duration _currentTime = const Duration(seconds: 0);

  EggTimer({
    this.maxTime,
  });

  get currentTime{
    return _currentTime;
  }

  set currentTime(newTime){
    if(state == EggTimerState.ready){
      _currentTime = newTime;
    }
  }

}

enum EggTimerState{
  ready,
  running,
  paused,
}