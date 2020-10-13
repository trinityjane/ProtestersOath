import 'package:equatable/equatable.dart';

import 'ProtestModel.dart';

abstract class ProtestsState extends Equatable {}

class InitialState extends ProtestsState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ProtestsState {
  @override
  List<Object> get props => [];
}

class LoadedState extends ProtestsState {
  LoadedState(this.protest);

  final ProtestModel protest;

  @override
  List<Object> get props => [protest];
}

class ErrorState extends ProtestsState {
  @override
  List<Object> get props => [];
}
