import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recyclingvin_web/helpers/enums.dart';

final triggerLaserProvider = StateProvider.autoDispose<VinShootingOptions>((ref) => VinShootingOptions.none);

final vinPositionProvider = StateProvider<double?>((ref) => null);

final waterBottleCount = StateProvider<int>((ref) => 0);
final sodaCanCount = StateProvider<int>((ref) => 0);
final trashBagCount = StateProvider<int>((ref) => 0);
final cardboardCount = StateProvider<int>((ref) => 0);