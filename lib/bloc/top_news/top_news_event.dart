import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TopNewsEvents extends Equatable {
  const TopNewsEvents();
}

//like StartEvent in a last porject
class StartEvent extends TopNewsEvents {
  @override
  List<Object?> get props => throw UnimplementedError();
}
