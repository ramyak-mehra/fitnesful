import 'package:fit_kit/fit_kit.dart';
import 'dart:async';

String result = '';
Map<DataType, List<FitData>> energy = Map();
bool permissions;
final enerrgy =
    energy.entries.expand((entry) => [entry.key, ...entry.value]).toList();

Map<DataType, List<FitData>> steps = Map();

final stepss =
    steps.entries.expand((entry) => [entry.key, ...entry.value]).toList();
Future<bool> hasPermissionss() async {
  try {
    permissions =
        await FitKit.hasPermissions([DataType.ENERGY, DataType.ENERGY]);
    return true;
  } catch (e) {
    result = 'hasPermissions: $e';
    return false;
  }
}

Future readEnergy() async {
  try {
    permissions = await FitKit.requestPermissions([DataType.ENERGY]);
    if (!permissions) {
      result = 'requestPermissions: failed';
    } else {
      for (DataType type in [DataType.ENERGY]) {
        energy[type] = await FitKit.read(type,
            dateFrom: DateTime.now().subtract(Duration(days: 2)),
            dateTo: DateTime.now(),
            limit: null);
      }

      final item = enerrgy[0];

      return energy[item].length.toString();
    }
  } catch (e) {
    result = 'readAll: $e';
    print(result);
    return null;
  }
}

Future readSteps() async {
  try {
    permissions = await FitKit.requestPermissions([DataType.STEP_COUNT]);
    if (!permissions) {
      result = 'requestPermissions: failed';
    } else {
      for (DataType type in [DataType.STEP_COUNT]) {
        steps[type] = await FitKit.read(type,
            dateFrom: DateTime.now().subtract(Duration(days: 2)),
            dateTo: DateTime.now(),
            limit: null);
      }

      final item = stepss[0];
      return steps[item].length.toString();
    }
  } catch (e) {
    return null;
  }
}
