import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AllNewsEvents extends Equatable {
  const AllNewsEvents();
}

//like StartEvent in a last porject
class AllNewsStartEvent extends AllNewsEvents {
  @override
  List<Object?> get props => throw UnimplementedError();
}
