

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_app/models/m_utils.dart';

typedef AreaUnitEntry = DropdownMenuEntry<AreaUnitLable>;

enum AreaUnitLable {
  sqM("Square Meter", AreaUnit.sqM),
  sqFt("Square Feet", AreaUnit.sqFt),
  hectare("Hectare", AreaUnit.hectare),
  acre("Acre", AreaUnit.acre),
  guntha("Guntha", AreaUnit.guntha);

  const AreaUnitLable(this.label, this.data);

  final String label;
  final AreaUnit data;

  static final List<AreaUnitEntry> entries = UnmodifiableListView<AreaUnitEntry>(
    values.map(
      (AreaUnitLable area){
        return AreaUnitEntry(
          label: area.label,
          value: area
        );
      }
    )
  );
}
