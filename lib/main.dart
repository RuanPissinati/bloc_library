import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc():super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async*{
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
    }
  }
}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  CounterBloc bloc = CounterBloc();

  for (int i = 0; i < 3; i++) {
    bloc.add(CounterEvent.increment);
  }
}