import 'package:carsh/l10n/localization.dart';
import 'package:carsh/model/distance.dart';
import 'package:carsh/model/fuel_unit.dart';

enum FuelCunsumptionMetric implements FuelConsumption {
  DistancePerQuantity(DistancePerQuantityFuelConsumption()),
  QuantityPerDistance(_QuantityPerDistanceFuelConsumption()),
  QuentityPer100Distance(_QuantityPer100DistanceFuelConsumption());

  const FuelCunsumptionMetric(this._impl);

  final FuelConsumption _impl;
  
  double calculate(double distance, double quantity) => _impl.calculate(distance, quantity);
  String unit(Localization loc, Distance? distanceUnit, FuelUnit? fuelUnit) => _impl.unit(loc, distanceUnit, fuelUnit);
}

abstract class FuelConsumption {
  double calculate(double distance, double quantity);
  String unit(Localization loc, Distance? distanceUnit, FuelUnit? fuelUnit);
}

class DistancePerQuantityFuelConsumption implements FuelConsumption {
  const DistancePerQuantityFuelConsumption();
  double calculate(double distance, double quantity) => distance/quantity;
  String unit(Localization loc, Distance? distanceUnit, FuelUnit? fuelUnit) => "${distanceUnit?.abbreviated()}/${loc.ttr(fuelUnit?.nameAbbreviated)}";
}

class _QuantityPerDistanceFuelConsumption implements FuelConsumption {
  const _QuantityPerDistanceFuelConsumption();
  double calculate(double distance, double quantity) => quantity/distance;
  String unit(Localization loc, Distance? distanceUnit, FuelUnit? fuelUnit) => "${loc.ttr(fuelUnit?.nameAbbreviated)}/${distanceUnit?.abbreviated()}";
}

class _QuantityPer100DistanceFuelConsumption implements FuelConsumption {
const _QuantityPer100DistanceFuelConsumption();
  double calculate(double distance, double quantity) => quantity/distance*100;
  String unit(Localization loc, Distance? distanceUnit, FuelUnit? fuelUnit) => "${loc.ttr(fuelUnit?.nameAbbreviated)}/100 ${distanceUnit?.abbreviated()}";
}