class MeasurementTable {
  static const String tableName = 'measurements';
  static const String id = 'id';
  static const String weight = 'weight';
  static const String fat = 'fat_percentage';
  static const String water = 'water';
  static const String muscle = 'muscle';
  static const String bone = 'bone';
  static const String visceral = 'visceral_fat';
  static const String basal = 'basal';
  static const String bmi = 'bmi';
  static const String measuredAt = 'measured_at';
  static const String measuredAtMonth = 'measured_at_month';
  static const String measuredAtYear = 'measured_at_year';

  static String createTable() {
    return "CREATE TABLE ${MeasurementTable.tableName} ("
        "${MeasurementTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${MeasurementTable.weight} REAL NOT NULL,"
        "${MeasurementTable.fat} REAL,"
        "${MeasurementTable.water} REAL,"
        "${MeasurementTable.muscle} REAL,"
        "${MeasurementTable.bone} REAL,"
        "${MeasurementTable.visceral} REAL,"
        "${MeasurementTable.basal} REAL,"
        "${MeasurementTable.bmi} REAL,"
        "${MeasurementTable.measuredAt} TEXT NOT NULL,"
        "${MeasurementTable.measuredAtMonth} INTEGER NOT NULL,"
        "${MeasurementTable.measuredAtYear} INTEGER NOT NULL"
        ")";
  }
}
